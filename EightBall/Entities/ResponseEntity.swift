//
//  ResponseEntity.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 31.01.2022.
//

import Foundation

struct ResponseEntity {
    let question: String
    let answer: String
}

extension ResponseEntity: Decodable {
    enum OuterKeys: String, CodingKey {
        case magic
    }
    enum MagicKeys: String, CodingKey {
        case question
        case answer
    }
    
    // Flattens the received JSON and cuts extra properties off
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let magicContainer = try outerContainer.nestedContainer(keyedBy: MagicKeys.self, forKey: .magic)
        
        self.question = try magicContainer.decode(String.self, forKey: .question)
        self.answer = try magicContainer.decode(String.self, forKey: .answer)
    }
}
