//
//  PredefinedAnswersStorable.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 22.02.2022.
//

protocol PredefinedAnswersStorable {
    associatedtype PredefinedAnswer

    func setPredefinedAnswersStore<T: PredefinedAnswersStore>(_ predefinedAnswersStore: T) where T.PredefinedAnswer == PredefinedAnswer
}

