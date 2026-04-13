//
//  ContentView.swift
//  mobileModule00
//
//  Created by Shehani Hansika on 13.04.26.
//

import SwiftUI

struct ex01View: View {
    let darkGreen = Color(red: 0.0, green: 0.5, blue: 0.0)
    
    @State private var oldText = "Module00 - EX01"
    
    var body: some View {
        VStack {
            Text(oldText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .background(darkGreen.opacity(0.7))
                .cornerRadius(10)
                .padding()
            
            Button(action: clickMe) {
                Text("Click me")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(28)
        }
    }
    
    private func clickMe() {
        if oldText == "Module00 - EX01" {
            oldText = "Hello World!"
        } else {
            oldText = "Module00 - EX01"
        }
        print("Button pressed!")
    }
}

#Preview {
    ex01View()
}
