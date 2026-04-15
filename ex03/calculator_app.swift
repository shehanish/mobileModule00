//
//  calculator_app.swift
//  mobileModule00
//
//  Created by Shehani Hansika on 14.04.26.
//

import SwiftUI

struct CalculatorAppView: View {
    
    let navyBlue = Color(red: 0.1, green: 0.3, blue: 0.4)
    
    // UI State for the displays
    @State private var expression: String = ""
    @State private var result: String = "0"
    
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
                .padding(.bottom, 30)
                
                // Buttons Area - Using perfectly aligned Grid
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    
                    GridRow {
                        CalcuButtonView(name: "AC", action: handleButtonTap)
                            .gridCellColumns(2) // Spans 2 columns perfectly
                        CalcuButtonView(name: "C", action: handleButtonTap)
                        CalcuButtonView(name: "÷", action: handleButtonTap)
                    }
                    
                    GridRow {
                        CalcuButtonView(name: "7", action: handleButtonTap)
                        CalcuButtonView(name: "8", action: handleButtonTap)
                        CalcuButtonView(name: "9", action: handleButtonTap)
                        CalcuButtonView(name: "×", action: handleButtonTap)
                    }
                    
                    GridRow {
                        CalcuButtonView(name: "4", action: handleButtonTap)
                        CalcuButtonView(name: "5", action: handleButtonTap)
                        CalcuButtonView(name: "6", action: handleButtonTap)
                        CalcuButtonView(name: "-", action: handleButtonTap)
                    }
                    
                    GridRow {
                        CalcuButtonView(name: "1", action: handleButtonTap)
                        CalcuButtonView(name: "2", action: handleButtonTap)
                        CalcuButtonView(name: "3", action: handleButtonTap)
                        CalcuButtonView(name: "+", action: handleButtonTap)
                    }
                    
                    GridRow {
                        CalcuButtonView(name: "0", action: handleButtonTap)
                            .gridCellColumns(2) // Spans 2 columns perfectly
                        CalcuButtonView(name: ".", action: handleButtonTap)
                        CalcuButtonView(name: "=", action: handleButtonTap)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(navyBlue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
    
    // MARK: - Calculator Logic
    
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
            
        case "=":
            calculateResult()
            
        case "÷", "×", "-", "+":
            addOperator(button)
            
        case ".":
            addDecimal()
            
        default:
            expression += button
        }
    }
    
    func addOperator(_ op: String) {
        if let lastChar = expression.last {
            let operators = ["÷", "×", "-", "+"]
            if operators.contains(String(lastChar)) {
                expression.removeLast()
            }
        } else if op != "-" {
            return
        }
        expression += op
    }
    
    func addDecimal() {
        let components = expression.components(separatedBy: CharacterSet(charactersIn: "÷×-+"))
        if let lastNumber = components.last, !lastNumber.contains(".") {
            if lastNumber.isEmpty {
                expression += "0."
            } else {
                expression += "."
            }
        }
    }
    
    func calculateResult() {
        guard !expression.isEmpty else { return }
        
        var safeMath = expression
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
        
        if let lastChar = safeMath.last, ["+", "-", "*", "/", "."].contains(String(lastChar)) {
            safeMath.removeLast()
        }
        
        if safeMath.contains("/0") {
            result = "Error"
            return
        }
        
        let expr = NSExpression(format: safeMath)
        
        if let mathValue = expr.expressionValue(with: nil, context: nil) as? Double {
            if mathValue.isInfinite || mathValue.isNaN {
                result = "Error"
            } else if mathValue.truncatingRemainder(dividingBy: 1) == 0 {
                result = String(format: "%.0f", mathValue)
            } else {
                result = String(mathValue)
            }
        } else {
            result = "Error"
        }
    }
}


struct CalcuButtonView: View {
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
    
    var body: some View {
        Button(action: {
            action(name)
        }) {
            Text(name)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                // Give buttons a standard height so they look proportional
                // Grid handles the horizontal stretching perfectly
                .frame(minHeight: 70)
                .background(bgColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
    }
}

#Preview {
    CalculatorAppView()
}
