//
//  SettingsModuleBuilder.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 05.02.2022.
//

struct SettingsModuleBuilder {
    static func build() -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter()
        let store = InMemoryStore.shared
        
        presenter.setPredefinedAnswersStore(store)
        viewController.presenter = presenter
        
        return viewController
    }
}
