//
//  MainViewDrawerDelegate.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 31.01.2022.
//

import UIKit

@objc protocol MainViewDrawerDelegate: UITextFieldDelegate {
    var hostingViewSafeAreaLayoutGuide: UILayoutGuide { get }
    
    func addSubviewToHostingView(_ subview: UIView)
    
    @objc optional func clearAnswerButtonTapped(_ sender: UIButton)
    @objc optional func shareAnswerButtonTapped(_ sender: UIButton)
    
    // FIXME: Debug, to delete
    @objc optional func switchQuestionAnswerModesTapped()
}
