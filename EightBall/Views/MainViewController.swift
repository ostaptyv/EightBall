//
//  MainViewController.swift
//  Eight Ball
//
//  Created by Ostap Tyvonovych on 27.01.2022.
//

import UIKit
import Dispatch

class MainViewController: UIViewController, MainViewDrawerDelegate, UITextFieldDelegate, MainViewProtocol {
    
    var presenter: MainPresenter!
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
        animateButtonTap(using: sender)
        
        viewDrawer.answerLabel.text = nil
        viewDrawer.questionTextField.becomeFirstResponder()
        
        switchQuestionAnswerModes(isQuestionMode: true)
    }
    func shareAnswerButtonTapped(_ sender: UIButton) {
        animateButtonTap(using: sender)
        
        let textToShare = presenter.getShareText()
        let activityVC = UIActivityViewController(activityItems: [textToShare],
                                                  applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    func switchQuestionAnswerModes(isQuestionMode: Bool) {
        viewDrawer.questionTextField.isHidden = !isQuestionMode
        viewDrawer.answerLabel.isHidden = isQuestionMode
        viewDrawer.clearAnswerButton.isHidden = isQuestionMode
        viewDrawer.shareAnswerButton.isHidden = isQuestionMode
    }
    
    // MARK: - Text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // MARK: - Handle data from presenter
    
    func didReceiveAnswer(_ answer: String) {
        viewDrawer.answerLabel.text = answer
        switchQuestionAnswerModes(isQuestionMode: false)
        viewDrawer.questionTextField.text = nil
        viewDrawer.questionTextField.isEnabled = true
    }
    
    // MARK: - Handle shake motion
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && !presenter.isRequestInProgress {
            let isRequestAccepted = presenter.getAnswer(toQuestion: viewDrawer.questionTextField.text)
            if isRequestAccepted {
                viewDrawer.questionTextField.resignFirstResponder()
                viewDrawer.questionTextField.isEnabled = false
            }
        }
        
        super.motionBegan(motion, with: event)
    }
    
    // MARK: - Private methods
    
    private func animateButtonTap(using view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut) {
            view.alpha = 0.5
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            view.alpha = 1.0
        }
    }
}
