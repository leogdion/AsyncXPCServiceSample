//
//  SwiftProtocol.swift
//  XPCApp
//
//  Created by Leo Dion on 2/18/25.
//



public protocol AsyncService {
  func performCalculation(firstNumber: Int, secondNumber: Int) async throws -> Int
}
