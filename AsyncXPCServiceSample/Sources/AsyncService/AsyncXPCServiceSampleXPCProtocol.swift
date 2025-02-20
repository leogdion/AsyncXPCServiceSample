//
//  AsyncXPCServiceSampleXPCProtocol.swift
//  AsyncXPCServiceSampleXPC
//
//  Created by Leo Dion on 2/20/25.
//

import AsyncXPCConnection
import Foundation
import AsyncServiceXPC

@available(macOS 13.0, *)
public struct AsyncServiceImpl : AsyncService, Sendable {
  public init () {
    
  }
  public func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int {
    try? await Task.sleep(for: .seconds(.random(in: 0...5)))
    return firstNumber + secondNumber
  }
  
  
}


public protocol AsyncServiceContainer {
  var asyncService: AsyncService { get }
}



public protocol AsyncService {
  func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int
}

extension RemoteXPCService : AsyncService where Service : AsyncXPCServiceSampleXPCProtocol  {
  
  public func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int {
    try! await self.withContinuation { service, continuation in
      service.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber) { value in
        continuation.resume(returning: value)
      }
    }
//    try! await self.withValueErrorCompletion { service, completion in
//      service.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber) { value in
//        
//      }
//    }
  }
}


/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     connectionToService = NSXPCConnection(serviceName: "com.brightdigit.AsyncXPCServiceSampleXPC")
     connectionToService.remoteObjectInterface = NSXPCInterface(with: AsyncXPCServiceSampleXPCProtocol.self)
     connectionToService.resume()

 Once you have a connection to the service, you can use it like this:

     if let proxy = connectionToService.remoteObjectProxy as? AsyncXPCServiceSampleXPCProtocol {
         proxy.performCalculation(firstNumber: 23, secondNumber: 19) { result in
             NSLog("Result of calculation is: \(result)")
         }
     }

 And, when you are finished with the service, clean up the connection like this:

     connectionToService.invalidate()
*/
