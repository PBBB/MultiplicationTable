//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by PBB on 2019/10/29.
//  Copyright © 2019 PBB. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSettings = true
    @State private var allQuestions = [(Int, Int)]()
    @State private var selectedQuestions = [(Int, Int)]()
    @State private var inputNumber = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            
            HStack {
                Spacer()
                Button("Restart Game") {
                    
                }
                .padding(.top, 10)
                .padding(.bottom, 80)
                .padding(.trailing, 20)
            }
            .frame(maxWidth: .infinity)
            Text("5 × 5")
                .font(.system(size: 100))
            TextField("Answer here", text: $inputNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding(.horizontal, 40)
            Text("You are right!")
                .padding(.top, 40)
                .font(.headline)
            Spacer()
            Text("1 / 10")
        }
    }
}

enum NumberOfQuestions {
    case number(Int)
    case all
    
    func description() -> String {
        switch self {
        case .number(let number):
            return String(number)
        default:
            return "All"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            SettingsView()
        }
    }
}

struct SettingsView: View {
    let numbersOfQuestions: [NumberOfQuestions] = [.number(5), .number(10), .number(20), .all]
    @State private var maxMulplicationNumber = 1
    @State private var seletedIndexOfNumber = 0
    private var totalNumberOfQuestions: Int {
        return maxMulplicationNumber * maxMulplicationNumber - maxMulplicationNumber
    }
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Multiplication Table")) {
                    Stepper("Up to: \(maxMulplicationNumber)", value: $maxMulplicationNumber, in: 1...12)
                }
                
                Section(header: Text("Number of Questions")) {
                    Picker("Number of questions", selection: $seletedIndexOfNumber) {
                        ForEach(0..<numbersOfQuestions.count) { number in
                            Text("\(self.numbersOfQuestions[number].description())")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Start") {
                        
                    }
                }
                
            }
            .navigationBarTitle("Times Table Quiz")
        }
    }
}
