//
//  File.swift
//  AsyncXPCServiceSample
//
//  Created by Leo Dion on 2/20/25.
//

import AsyncXPCConnection
import AsyncServiceXPC
import Foundation


extension RemoteXPCService : AsyncService where Service : AsyncXPCServiceSampleXPCProtocol  {
  
  public func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int {
    try! await self.withContinuation { service, continuation in
      service.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber) { value in
        continuation.resume(returning: value)
      }
    }
  }
}

public enum ServiceFactory {
  public static func service () -> AsyncService {
    let connection = NSXPCConnection(serviceName: "com.brightdigit.AsyncXPCServiceSampleXPC")
    connection.remoteObjectInterface = NSXPCInterface(with: AsyncXPCServiceSampleXPCProtocol.self)
    connection.resume()
    
    return RemoteXPCService<AsyncXPCServiceSampleXPCProtocol>(connection: connection)
  }
}
