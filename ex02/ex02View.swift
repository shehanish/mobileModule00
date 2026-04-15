//
//  ex02.swift
//  mobileModule00
//
//  Created by Shehani Hansika on 13.04.26.
//

import SwiftUI

struct ex02View: View {
    
    let navyBlue = Color(red: 0.1, green: 0.3, blue: 0.4)
    
    // UI State for the displays
    @State private var expression: String = ""
    @State private var result: String = "0"
    
    // The layout of the calculator buttons
    let CalculatorButtons: [[String]] = [
        ["AC","C", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Display Area
                VStack(alignment: .trailing, spacing: 10) {
                    Spacer()
                    
                    Text(expression.isEmpty ? " " : expression)
                        .font(.title2)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                    
                    Text(result)
                        .font(.system(size: 60, weight: .light))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 80)
                
                // Buttons Area
                VStack(spacing: 12) {
                    ForEach(CalculatorButtons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { buttonName in
                                // Hide the empty placeholder button
                                if buttonName == "" {
                                    Color.clear
                                        .frame(maxWidth: .infinity)
                                    
                                } else {
                                    CalcButtonView(
                                        name: buttonName,
                                        action: { tappedButton in
                                            handleButtonTap(tappedButton)
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(navyBlue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .background(Color(.systemGray6).ignoresSafeArea())         }
    }
    
    func handleButtonTap(_ button: String) {
        
        print("Button pressed: \(button)")
        
        switch button {
        case "AC":
            expression = ""
            result = "0"
            
        case "C":
            if !expression.isEmpty {
                expression.removeLast()
            }
            
        default:
            expression += button
        }
    }

}


struct CalcButtonView: View {
    var name: String
    var action: (String) -> Void
    
    var bgColor: Color {
        switch name {
        case "1","2","3","4","5","6","7","8","9","0",".":
            return Color(.darkGray)
        case "AC", "C":
            return Color(.lightGray)
        default:
            return .orange
        }
    }
    
    var foregroundColor: Color {
        switch name {
        case "AC", "C":
            return .black
        default:
            return .white
        }
    }
    
    // Calculates how many columns a button should take up
    var buttonSpan: CGFloat {
        if name == "0" || name == "AC" || name == "=" {
            return 2
        } else {
            return 1
        }
    }
    
    var body: some View {
        Button(action: {
            action(name)
        }) {
            Text(name)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(bgColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
      
    }
}

#Preview {
    ex02View()
}
