//
//  ContentView.swift
//  mobileModule00
//
//  Created by Shehani Hansika on 13.04.26.
//

import SwiftUI

let darkGreen = Color(red: 0.0, green: 0.5, blue: 0.0)
struct ex00View: View {
    var body: some View {
        VStack {
            Text("Module00 - EX00")
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
        print("Button pressed!")
    }
}

#Preview {
    ex00View()
}
