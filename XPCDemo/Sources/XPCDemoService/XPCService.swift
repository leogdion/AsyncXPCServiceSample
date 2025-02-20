//
//  XPCService.swift
//  XPCService
//
//  Created by Leo Dion on 2/18/25.
//

import Foundation
import XPCDemo

@objc public protocol XPCServiceProtocol {
    
    /// Replace the API of this protocol with an API appropriate to the service you are vending.
  func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping @Sendable (NSNumber?, Error?) -> Void)
}


/// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@available(macOS 13.0, *)
public final class XPCService: XPCServiceProtocol {
  let implementation  = XPCImplementation()
  public init () {}
  public func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping @Sendable (NSNumber?, (any Error)?) -> Void) {
    
    
    implementation.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber, with: reply)
  }

  
    
//    /// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
//    @objc func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping (Int) -> Void) {
//        let response = firstNumber + secondNumber
//        reply(response)
//    }
}



