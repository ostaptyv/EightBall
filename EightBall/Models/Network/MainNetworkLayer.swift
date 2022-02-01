//
//  MainNetworkLayer.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 31.01.2022.
//

import Foundation

class MainNetworkLayer {
    
    private let session: URLSession
    private weak var delegate: MainNetworkLayerDelegate?
    
    private struct EightBallAPI {
        static let scheme = "https"
        static let host = "8ball.delegator.com"
        static let path = "/magic/JSON"
    }
    
    // MARK: - Public interface
    
    public func loadAnswer(toQuestion question: String) {
        let request = constructURLRequest(question: question)
        let dataTask = session.dataTask(with: request) { [weak self] data, urlResponse, error in
            if let error = error {
                print("ERROR: \((error as NSError).code == URLError.notConnectedToInternet.rawValue)")
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse, (200...209).contains(httpResponse.statusCode) else {
                fatalError("Bad request from the server side. Contact the backend team")
            }
            guard let mimeType = httpResponse.mimeType else {
                fatalError("Couldn't retrieve MIME type")
            }
            guard mimeType == "application/json" else {
                fatalError("The data server sent doesn't contain JSON")
            }
            
            let responseEntity = try! JSONDecoder().decode(ResponseEntity.self, from: data!)
            
            DispatchQueue.main.async {
                self?.delegate?.networkRequestDidCompleteSuccessfully(with: responseEntity)
            }
            
        }
        dataTask.resume()
    }
    
    public init(delegate: MainNetworkLayerDelegate) {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.waitsForConnectivity = true
        
        let session = URLSession(configuration: sessionConfiguration)
        self.session = session
        
        self.delegate = delegate
    }
    
    // MARK: - Private methods
    
    private func constructURLRequest(question: String) -> URLRequest {
        var components = URLComponents()
        components.scheme = EightBallAPI.scheme
        components.host = EightBallAPI.host
        components.path = EightBallAPI.path + "/" + question
        
        if let url = components.url {
            return URLRequest(url: url)
        } else {
            fatalError("Couldn't create request URL. URLComponents' debug description: \(components.debugDescription)")
        }
    }
    
}
