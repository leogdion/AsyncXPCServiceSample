//
//  ContentView.swift
//  AsyncXPCServiceSampleApp
//
//  Created by Leo Dion on 2/20/25.
//

import SwiftUI

struct ContentView: View {
  @State var object : ServiceObject = .init()
    var body: some View {
      HStack{
        Button("Randomize") {
          object.randomize()
        }
        TextField(
          "a",
          value: self.$object.firstNumber,
          format: .number
        )
        Text("+")
        TextField(
          "b",
          value: self.$object.secondNumber,
          format: .number
        )
        Button("=") {
          Task {
            await object.performCalculation()
          }
        }
        TextField("sum", text: .constant( self.object.sum.map(\.description) ?? ""), prompt: Text("")).disabled(true)
      }
      .frame(width: 300)
      .padding(10)
    }
}

#Preview {
    ContentView()
}
