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
    @State private var questions = [Question(firstNumber: 1, secondNumber: 1)]
//    @State private var numberOfQuestions: NumberOfQuestions = .number(1)
//    @State private var maxMulplicationNumber  = 1
//    @State private var selectedQuestions = [(Int, Int)]()
    
    
    var body: some View {
        QuestionView(questions: $questions, showingSettings: $showingSettings)
            .sheet(isPresented: $showingSettings) {
                SettingsView(showingSettings: self.$showingSettings, questions: self.$questions)
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
//            SettingsView()
        }
    }
}

struct SettingsView: View {
    let numbersOfQuestions: [NumberOfQuestions] = [.number(5), .number(10), .number(20), .all]
//    @State private var maxMulplicationNumber = 1
    @State private var selectedIndexOfNumber = 0
//    @State private var numberOfQuestions: NumberOfQuestions = .number(5)
    @State private var maxMulplicationNumber: Int = 1
    @Binding var showingSettings: Bool
    @Binding var questions: [Question]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Multiplication Table")) {
                    Stepper("Up to: \(maxMulplicationNumber)", value: $maxMulplicationNumber, in: 1...12)
                }
                
                Section(header: Text("Number of Questions")) {
                    Picker("Number of questions", selection: $selectedIndexOfNumber) {
                        ForEach(0..<numbersOfQuestions.count) { number in
                            Text("\(self.numbersOfQuestions[number].description())")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Start") {
                        self.showingSettings = false
                        let questionFactory = QuestionFactory(maxMulplicationNumber: self.maxMulplicationNumber)
                        self.questions = questionFactory.questionsofNumber(self.numbersOfQuestions[self.selectedIndexOfNumber])
                    }
                }
            }
            .navigationBarTitle("Times Table Quiz")
        }
    }
}

struct QuestionView: View {
    @Binding var questions: [Question]
    @Binding var showingSettings: Bool
    @State private var inputNumber = ""
    @State private var currentNumberOfQuestion = 0
    @State private var score = 0
    @State private var showScore = false
    
    private var totalNumbersOfQuestion: Int {
        questions.count
    }
    private var scorePercent: Double {
        Double(score) / Double(questions.count) * 100
    }
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            
            HStack {
                Spacer()
                Button("Restart Game") {
                    self.showingSettings = true
                }
                .padding(.top, 10)
                .padding(.bottom, 80)
                .padding(.trailing, 20)
            }
            .frame(maxWidth: .infinity)
            Text(questions[currentNumberOfQuestion].questionText)
                .font(.system(size: 100))
            TextField("Answer here", text: $inputNumber, onCommit: nextQuestion)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding(.horizontal, 40)
            Spacer()
            Text("\(currentNumberOfQuestion + 1) / \(totalNumbersOfQuestion)")
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text("Questions Finished!"), message: Text("You scored \(self.scorePercent, specifier: "%.2g")%"), dismissButton: .default(Text("Restart Game"), action: {
                self.showingSettings = true
                self.score = 0
                self.currentNumberOfQuestion = 0
            }))
        }
    }
    
    func nextQuestion() {
        if inputNumber == questions[currentNumberOfQuestion].answerText {
            score += 1
        }
        if currentNumberOfQuestion == questions.count - 1 {
            showScore = true
        } else {
            currentNumberOfQuestion += 1
        }
        inputNumber = ""
    }
}
