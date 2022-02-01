//
//  MainNetworkLayerDelegate.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 31.01.2022.
//

protocol MainNetworkLayerDelegate: AnyObject {
    func networkRequestDidCompleteSuccessfully(with response: ResponseEntity)
}
