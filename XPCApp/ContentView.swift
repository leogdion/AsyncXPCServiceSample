//
//  ContentView.swift
//  XPCApp
//
//  Created by Leo Dion on 2/18/25.
//

import SwiftUI
import XPC
import XPCService
import Service
import AsyncXPCConnection

extension RemoteXPCService : @retroactive SwiftProtocol where Service : XPCServiceProtocol {
  public func performCalculation(firstNumber: Int, secondNumber: Int) async throws -> Int {
    let number = try await self.withValueErrorCompletion { service, completion in
      service.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber, with: completion)
    }
    return number.intValue
  }
  
  
}
@Observable
class XPCServiceObject {
  var value: Int = 0
  var firstNumber: Int = 0
  var secondNumber: Int = 0
 // let connectionToService: NSXPCConnection
  let service : SwiftProtocol
  init () {
let  connectionToService = NSXPCConnection(serviceName: "com.brightdigit.XPCService")
//    connectionToService.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
//    connectionToService.resume()
    let service : RemoteXPCService<XPCServiceProtocol>
    service = .init(connection: connectionToService,remoteInterface: XPCServiceProtocol.self)
    connectionToService.resume()
    self.service = service
  }
  
  func calculate () async {
    do {
      self.value = try await service.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber)
    } catch {
      print(error.localizedDescription)
    }
//    try? service.withContinuation { service, continuation in
//      service.performCalculation(firstNumber: self._firstNumber, secondNumber: self.secondNumber) { result in
//        continuation.resume(returning: result)
//      }
//    }
//    if let proxy = connectionToService.remoteObjectProxy as? XPCServiceProtocol {
//        proxy.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber) { result in
//          self.value = result
//        }
//    }
  }
}
struct ContentView: View {
  @State var service = XPCServiceObject()
    var body: some View {
        VStack {
          TextField("First Number", value: $service.firstNumber, format: .number)
          TextField("Second Number", value: $service.secondNumber, format: .number)
          Button("Calcualte") {
            Task {
              await service.calculate()
            }
          }
          Text("\(service.value)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
