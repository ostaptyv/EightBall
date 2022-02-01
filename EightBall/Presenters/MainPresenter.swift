//
//  MainPresenter.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 31.01.2022.
//

import Foundation

class MainPresenter: MainNetworkLayerDelegate {
    
    private var latestResponse: ResponseEntity?
    
    private weak var view: MainViewProtocol?
    var networkLayer: MainNetworkLayer!
    
    // MARK: - Public interface
    
    public private(set) var isRequestInProgress = false
    
    public func getAnswer(toQuestion question: String?) -> Bool {
        guard let question = question, !question.isEmpty else {
            // TODO: TODO: Consider creating some UI alert to indicate the user that they are trying to get an answer for an empty string
            return false
        }
        guard !isRequestInProgress else {
            return false
        }
        
        isRequestInProgress = true
        networkLayer.loadAnswer(toQuestion: question)
        return true
    }
    
    public func getShareText() -> String {
        guard let response = latestResponse else {
            fatalError("\(#function) method was toggled before any successful Internet request was made; latestResponse == nil")
        }
        
        return response.question + " - " + response.answer
    }
    
    public init(view: MainViewProtocol) {
        self.view = view
    }
    
    // MARK: - Main network layer delegate
    
    func networkRequestDidCompleteSuccessfully(with response: ResponseEntity) {
        view?.didReceiveAnswer(response.answer)
        latestResponse = response
        isRequestInProgress = false
    }
}
