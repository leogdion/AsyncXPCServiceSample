//
//  AsyncXPCServiceSampleXPCProtocol.swift
//  AsyncXPCServiceSampleXPC
//
//  Created by Leo Dion on 2/20/25.
//

import Foundation

/// The protocol that this service will vend as its API. This protocol will also need to be visible to the process hosting the service.
@objc public protocol AsyncServiceXPCProtocol {
    
    /// Replace the API of this protocol with an API appropriate to the service you are vending.
  func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @Sendable @escaping (Int) -> Void)
  
    
}
