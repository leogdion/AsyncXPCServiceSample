//
//  AsyncXPCServiceSampleXPCProtocol.swift
//  AsyncXPCServiceSampleXPC
//
//  Created by Leo Dion on 2/20/25.
//

import Foundation

public protocol AsyncService {
  func performCalculation(firstNumber: Int, secondNumber: Int) async -> Int
}
