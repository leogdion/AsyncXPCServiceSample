//
//  ServiceObject.swift
//  AsyncXPCServiceSampleApp
//
//  Created by Leo Dion on 2/20/25.
//

import AsyncClient
import Observation

@Observable
class ServiceObject {
  let service : any AsyncService = ServiceFactory.service()
  var firstNumber : Int = .random(in: 0..<1000) {
    willSet {
      self.sum = nil
    }
  }
  var secondNumber : Int = .random(in: 0..<1000){
    willSet {
      self.sum = nil
    }
  }
  var sum: Int? = nil
  
  init() {
  }
  
  func randomize () {
    self.firstNumber = .random(in: 0..<1000)
    self.secondNumber = .random(in: 0..<1000)
  }
  
  func performCalculation () async {
    Task {
      self.sum = await service.performCalculation(firstNumber: firstNumber, secondNumber: secondNumber)
    }
  }
}
