//
//  AnyPredefinedAnswersStore.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 06.02.2022.
//

final class AnyPredefinedAnswersStore<PredefinedAnswer>: PredefinedAnswersStore {
    private let _numberOfAnswers: () -> Int
    private let _writePredefinedAnswer: (PredefinedAnswer) -> Void
    private let _predefinedAnswerAtIndex: (Int) -> PredefinedAnswer
    private let _deletePredefinedAnswerAtIndex: (Int) -> Void
    
    // MARK: - Public interface

    func numberOfAnswers() -> Int {
        return _numberOfAnswers()
    }
    
    func write(_ predefinedAnswer: PredefinedAnswer) {
        _writePredefinedAnswer(predefinedAnswer)
    }
    func predefinedAnswer(at index: Int) -> PredefinedAnswer {
        return _predefinedAnswerAtIndex(index)
    }
    func deletePredefinedAnswer(at index: Int) {
        _deletePredefinedAnswerAtIndex(index)
    }
    
    init<S: PredefinedAnswersStore>(_ predefinedAnswersStore: S) where S.PredefinedAnswer == PredefinedAnswer {
        
        self._numberOfAnswers = predefinedAnswersStore.numberOfAnswers
        self._writePredefinedAnswer = predefinedAnswersStore.write(_:)
        self._predefinedAnswerAtIndex = predefinedAnswersStore.predefinedAnswer(at:)
        self._deletePredefinedAnswerAtIndex = predefinedAnswersStore.deletePredefinedAnswer(at:)
    }
}
