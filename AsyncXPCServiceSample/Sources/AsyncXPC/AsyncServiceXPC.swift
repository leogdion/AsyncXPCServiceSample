//
//  AsyncXPCServiceSampleXPC.swift
//  AsyncXPCServiceSampleXPC
//
//  Created by Leo Dion on 2/20/25.
//

import Foundation
import AsyncServiceXPC
import AsyncService

/// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
class AsyncServiceXPC: NSObject, AsyncServiceXPCProtocol {
  let implementation = AsyncServiceImpl()
    /// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
  @objc  func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @Sendable @escaping (Int) -> Void) {
    Task { [implementation] in

        
        let value = await implementation.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber)

        reply(value)

    }
  }
}
