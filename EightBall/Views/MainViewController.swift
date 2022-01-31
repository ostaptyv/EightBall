//
//  MainViewController.swift
//  Eight Ball
//
//  Created by Ostap Tyvonovych on 27.01.2022.
//

import UIKit
import Dispatch

class MainViewController: UIViewController, MainViewDrawerDelegate, UITextFieldDelegate {
    
    private let viewDrawer = MainViewDrawer()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isKeyboardDismissedWhenTappedOutside = true
        self.navigationItem.title = "Main"
        
        viewDrawer.delegate = self
        viewDrawer.setupInterface()
    }
    override func viewDidLayoutSubviews() {
        viewDrawer.ballView.setNeedsLayout()
        viewDrawer.ballView.layoutIfNeeded()
        viewDrawer.ballView.layer.cornerRadius = viewDrawer.ballView.layer.bounds.width / 2
    }
    
    // MARK: - View drawer delegate
    
    var hostingViewSafeAreaLayoutGuide: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    func addSubviewToHostingView(_ subview: UIView) {
        self.view.addSubview(subview)
    }
    
    func clearAnswerButtonTapped(_ sender: UIButton) {
        // FIXME: Debug, to delete
        print("clearAnswerButtonTapped")
        
        // Button tapping animation
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut) {
            sender.alpha = 0.5
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            sender.alpha = 1.0
        }
        
        viewDrawer.questionTextField.text = nil
        viewDrawer.questionTextField.becomeFirstResponder()
        switchQuestionAnswerModesTapped()
    }
    func shareAnswerButtonTapped(_ sender: UIButton) {
        // FIXME: Debug, to delete
        print("shareAnswerButtonTapped")
        
        // Button tapping animation
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut) {
            sender.alpha = 0.5
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            sender.alpha = 1.0
        }
        
        let activityVC = UIActivityViewController(activityItems: ["Placeholder here!"],
                                                  applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    @objc func switchQuestionAnswerModesTapped() {
        // FIXME: Debug, to delete
        print("switchQuestionAnswerModesTapped")
        
        viewDrawer.questionTextField.isHidden = !viewDrawer.questionTextField.isHidden
        viewDrawer.answerLabel.isHidden = !viewDrawer.answerLabel.isHidden
        viewDrawer.clearAnswerButton.isHidden = !viewDrawer.clearAnswerButton.isHidden
        viewDrawer.shareAnswerButton.isHidden = !viewDrawer.shareAnswerButton.isHidden
        
        // FIXME: Debug, to delete; button to switch between Question and Answer modes
        if viewDrawer.questionTextField.isHidden {
            viewDrawer.switchQuestionAnswerModes.backgroundColor = .systemGreen
        } else {
            viewDrawer.switchQuestionAnswerModes.backgroundColor = .systemRed
        }
    }
    
    // MARK: - Text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
