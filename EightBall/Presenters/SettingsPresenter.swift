//
//  SettingsPresenter.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 04.02.2022.
//

import Foundation
import SwiftUI

class SettingsPresenter {
    private var store: AnyPredefinedAnswersStore<PredefinedAnswerEntity>!
    
    // MARK: - Public interface
    
    var numberOfAnswers: Int {
        return store.numberOfAnswers()
    }
    
    func predefinedAnswerText(at index: Int) -> String {
        let predefinedAnswer = store.predefinedAnswer(at: index)
        return predefinedAnswer.text
    }
    func write(_ predefinedAnswerText: String?) {
        guard let predefinedAnswerText = predefinedAnswerText else {
            fatalError("Nil string of predefined answer was passed to the presenter")
        }
        guard !predefinedAnswerText.isEmpty else {
            return
        }
        
        let predefinedAnswer = PredefinedAnswerEntity(text: predefinedAnswerText)
        store.write(predefinedAnswer)
    }
    func deletePredefinedAnswer(at index: Int) {
        store.deletePredefinedAnswer(at: index)
    }
}

// MARK: - 'Storable' protocol requirements

extension SettingsPresenter: PredefinedAnswersStorable {
    typealias PredefinedAnswer = PredefinedAnswerEntity
    
    func setPredefinedAnswersStore<T: PredefinedAnswersStore>(_ predefinedAnswersStore: T) where T.PredefinedAnswer == PredefinedAnswerEntity {
        guard store == nil else {
            return
        }
        self.store = AnyPredefinedAnswersStore(predefinedAnswersStore)
    }
}
