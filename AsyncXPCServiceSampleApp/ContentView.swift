//
//  ContentView.swift
//  AsyncXPCServiceSampleApp
//
//  Created by Leo Dion on 2/20/25.
//

import SwiftUI
import AsyncService

@Observable
class ServiceObject {
  var firstNumber : Int = .random(in: 0..<1000) {
    willSet {
      self.sum = nil
    }
  }
  var secondNumber : Int = .random(in: 0..<1000){
    willSet {
      self.sum = nil
    }
  }
  var sum: Int? = nil
  let connection : NSXPCConnection
  
  init() {
    let connection = NSXPCConnection(serviceName: "com.brightdigit.AsyncXPCServiceSampleXPC")
    connection.remoteObjectInterface = NSXPCInterface(with: AsyncXPCServiceSampleXPCProtocol.self)
    connection.resume()
    self.connection = connection
  }
  
  func randomize () {
    self.firstNumber = .random(in: 0..<1000)
    self.secondNumber = .random(in: 0..<1000)
  }
  
  func performCalculation () {
    
    if let proxy = connection.remoteObjectProxy as? AsyncXPCServiceSampleXPCProtocol {
      proxy.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber) { result in
        self.sum = result
        }
    }
  }
}

struct ContentView: View {
  @State var object : ServiceObject = .init()
    var body: some View {
      HStack{
        Button("Randomize") {
          object.randomize()
        }
        TextField(
          "a",
          value: self.$object.firstNumber,
          format: .number
        )
        Text("+")
        TextField(
          "b",
          value: self.$object.secondNumber,
          format: .number
        )
        Button("=") {
          object.performCalculation()
        }
        TextField("sum", text: .constant( self.object.sum.map(\.description) ?? ""), prompt: Text("")).disabled(true)
      }
      .frame(width: 300)
      .padding(10)
    }
}

#Preview {
    ContentView()
}
