//
//  File.swift
//  AsyncXPCServiceSample
//
//  Created by Leo Dion on 2/20/25.
//

import AsyncXPCConnection
import AsyncServiceXPC
import Foundation
@_exported import AsyncService

extension RemoteXPCService : AsyncService where Service : AsyncServiceXPCProtocol  {  
  public func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int {
    try! await self.withContinuation { service, continuation in
      service.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber) { value in
        continuation.resume(returning: value)
      }
    }
  }
}

