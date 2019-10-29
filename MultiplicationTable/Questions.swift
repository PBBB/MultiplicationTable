//
//  Questions.swift
//  MultiplicationTable
//
//  Created by Issac Penn on 2019/10/29.
//  Copyright © 2019 PBB. All rights reserved.
//

import Foundation

struct QuestionFactory {
    var maxMulplicationNumber: Int
    
    var allQuestions: [Question] {
        var questions = [Question]()
        guard maxMulplicationNumber >= 1 else {
            return []
        }
        
        for firstNumber in 1...maxMulplicationNumber {
            for secondNumber in 1...maxMulplicationNumber {
                questions.append(Question(firstNumber: firstNumber, secondNumber: secondNumber))
            }
        }
        
        return questions
    }
    
    func questionsofNumber(_ number: NumberOfQuestions) -> [Question] {
        switch number {
        case .all:
            return allQuestions.shuffled()
        case .number(let number):
            //如果请求的题目数量大于总题目数，就多拿几次 random element
            if number >= allQuestions.count {
                var questions = allQuestions
                let numberOfQuestionsRemaining = number - allQuestions.count
                
                for _ in 1...numberOfQuestionsRemaining {
                    questions.append(allQuestions.randomElement() ?? Question(firstNumber: 1, secondNumber: 1))
                }
                
                return questions
            } else {
                let randomQuestions = allQuestions.shuffled()
                return Array(randomQuestions[0..<number])
            }
        }
    }
    
}

struct Question {
    var questionText: String
    var answerText: String
    
    init(firstNumber: Int, secondNumber: Int) {
        questionText = "\(firstNumber) × \(secondNumber)"
        answerText = "\(firstNumber *  secondNumber)"
    }
}
