//
//  AsyncServiceImpl.swift
//  AsyncXPCServiceSample
//
//  Created by Leo Dion on 2/20/25.
//

import AsyncService


@available(macOS 13.0, *)
internal struct AsyncServiceImpl : AsyncService, Sendable {
  internal init () {
    
  }
  internal func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int {
    try? await Task.sleep(for: .seconds(.random(in: 0...5)))
    return firstNumber + secondNumber
  }
  
  
}
