//
//  ex02.swift
//  mobileModule00
//
//  Created by Shehani Hansika on 13.04.26.
//

import SwiftUI


struct CalculatorView: View {
    
    let navyBlue = Color(red: 0.1, green: 0.3, blue: 0.4)
   
    
    var body: some View {
        NavigationStack {
            VStack  {
                Text("0")
                    .font(.largeTitle)
                    .padding()
                Text("0")
                 
                    .font(.largeTitle)
                Spacer()
            }
           
            VStack(spacing: 12) {
                                
                                ForEach(CalculatorButtons, id: \.self) { row in
                                    
                                    HStack(spacing: 12) { 
                                        // Loop through each button in the current row
                                        ForEach(row, id: \.self) { buttonName in
                                            
                                            // Call our custom button view below
                                            CalcButtonView(name: buttonName)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom)
            .navigationTitle("Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(navyBlue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}


struct CalcButtonView: View {
    var name: String
    
    var buttonWidth: CGFloat {
            if name == "0" {
                return 172
            } else if name == "AC" || name == "C" {
                return 125
            } else {
                return 80
            }
        }
    
    var bgColor: Color {
        switch name {
        case "1","2","3","4","5","6","7","8","9","0",".":
            return Color(.darkGray) // Swapped to dark gray to look better
        case "AC":
            return Color(.lightGray)
        default:
            return .orange
        }
    }
    
    var foregroundColor: Color {
        switch name {
        case "AC":
            return .black
        default:
            return .white
        }
    }
    
    var body: some View {
            Text(name)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: buttonWidth, height: 80)
                .background(bgColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(5)
                
                
        }
}

#Preview {
    CalculatorView()
}
