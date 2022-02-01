//
//  MainModuleBuilder.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 01.02.2022.
//

import Foundation

struct MainModuleBuilder {
    static func build() -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController)
        let networkLayer = MainNetworkLayer(delegate: presenter)
        
        viewController.presenter = presenter
        presenter.networkLayer = networkLayer
        
        return viewController
    }
}
