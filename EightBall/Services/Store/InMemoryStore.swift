//
//  InMemoryStore.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 04.02.2022.
//

final class InMemoryStore: PredefinedAnswersStore {
    private var storage = [PredefinedAnswerEntity]()
    
    // MARK: - Instance-creating methods
    
    static let shared = InMemoryStore()
    
    // MARK: - Predefined answers store public interface
    
    func numberOfAnswers() -> Int {
        return storage.count
    }
    
    func write(_ predefinedAnswer: PredefinedAnswerEntity) {
        storage.append(predefinedAnswer)
    }
    func predefinedAnswer(at index: Int) -> PredefinedAnswerEntity {
        return storage[index]
    }
    func deletePredefinedAnswer(at index: Int) {
        storage.remove(at: index)
    }
}
