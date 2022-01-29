//
//  TabBarController.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 28.01.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupTabs()
    }
    
    private func setupTabs() {
        let mainNC = UINavigationController(rootViewController: MainViewController())
        let settingsNC = UINavigationController(rootViewController: UIViewController()) // settings VC goes here in future
        
        let ballIcon = UIImage(systemName: "circle.fill")!
        let gearIcon = UIImage(systemName: "gear")!
        
        mainNC.tabBarItem = UITabBarItem(title: "Main", image: ballIcon, tag: 0)
        settingsNC.tabBarItem = UITabBarItem(title: "Settings", image: gearIcon, tag: 0)
        
        self.viewControllers = [mainNC, settingsNC]
    }
}
