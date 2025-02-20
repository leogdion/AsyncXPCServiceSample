// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Service

@available(macOS 13.0, *)
public actor XPCImplementation : AsyncService{
  public init () {}
  public func performCalculation(firstNumber: Int, secondNumber: Int) async throws -> Int {
    try await Task.sleep(for: .seconds(1.0))
    return firstNumber + secondNumber
  }
  
  
}

@available(macOS 13.0, *)
extension AsyncService where Self : Sendable  {
  public nonisolated func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping @Sendable (NSNumber?, (any Error)?) -> Void) {
    Task {
      var value : Int?
      var error: Error?
      do {
        value = try await self.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber)
      } catch let caughtError {
        error = caughtError
      }
      reply(value.map(NSNumber.init(value:)), error)
    }
  }
}
