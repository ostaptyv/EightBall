//
//  PredefinedAnswersStore.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 04.02.2022.
//

protocol PredefinedAnswersStore: AnyObject {
    associatedtype PredefinedAnswer
    
    func numberOfAnswers() -> Int
    
    func write(_ predefinedAnswer: PredefinedAnswer)
    func predefinedAnswer(at index: Int) -> PredefinedAnswer
    func deletePredefinedAnswer(at index: Int)
}
