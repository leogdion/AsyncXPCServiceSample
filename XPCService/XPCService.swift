//
//  XPCService.swift
//  XPCService
//
//  Created by Leo Dion on 2/18/25.
//

import Foundation



/// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
class XPCService: XPCImplementation, XPCServiceProtocol {
  func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping (NSNumber?, (any Error)?) -> Void) {
    Task {
      var number : NSNumber?
      var error : Error?
      do {
        let integer : Int
        integer = try await super.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber)
        number = .init(value: integer)
      } catch let caughtError {
        error = caughtError
      }
      reply(number, error)
    }
  }

  
    
//    /// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
//    @objc func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping (Int) -> Void) {
//        let response = firstNumber + secondNumber
//        reply(response)
//    }
}



