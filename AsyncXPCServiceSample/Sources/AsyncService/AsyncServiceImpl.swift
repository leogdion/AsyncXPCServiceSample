//
//  AsyncServiceImpl.swift
//  AsyncXPCServiceSample
//
//  Created by Leo Dion on 2/20/25.
//


@available(macOS 13.0, *)
public struct AsyncServiceImpl : AsyncService, Sendable {
  public init () {
    
  }
  public func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int {
    try? await Task.sleep(for: .seconds(.random(in: 0...5)))
    return firstNumber + secondNumber
  }
  
  
}