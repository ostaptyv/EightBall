//
//  MainViewController.swift
//  Eight Ball
//
//  Created by Ostap Tyvonovych on 27.01.2022.
//

import UIKit
import Dispatch

class MainViewController: UIViewController, UITextFieldDelegate {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var ballContentView: UIView!
    private var buttonsContentView: UIView!
    private var ballView: UIView!
    
    // FIXME: Debug, to delete; button to switch between Question and Answer modes
    private var switchQuestionAnswerModes: UIButton!
    
    private var questionTextField: UITextField!
    private var answerLabel: UILabel!
    private var clearAnswerButton: UIButton!
    private var shareAnswerButton: UIButton!
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
    }
    override func viewDidLayoutSubviews() {
        ballView.setNeedsLayout()
        ballView.layoutIfNeeded()
        ballView.layer.cornerRadius = ballView.layer.bounds.width / 2
    }
    
    // MARK: - Setup interface
    
    private func setupInterface() {
        self.view.isKeyboardDismissedWhenTappedOutside = true
        self.navigationItem.title = "Main"
        
        initializeInterface()
        setupViewHierarchy()
        constraintInterface()
    }
    
    // MARK: - Initalize UI
    
    private func initializeInterface() {
        scrollView = makeScrollView()
        contentView = makeContentView()
        ballContentView = makeBallContentView()
        buttonsContentView = makeButtonsContentView()
        ballView = makeBallView()
        
        // FIXME: Debug, to delete; button to switch between Question and Answer modes
        switchQuestionAnswerModes = makeSwitchQuestionAnswerModes()
        
        questionTextField = makeQuestionTextField()
        answerLabel = makeAnswerLabel()
        clearAnswerButton = makeClearAnswerButton()
        shareAnswerButton = makeShareAnswerButton()
    }
    
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        return scrollView
    }
    private func makeContentView() -> UIView {
        let contentView = UIView()
        
        return contentView
    }
    private func makeBallContentView() -> UIView {
        let ballContentView = UIView()
        
        return ballContentView
    }
    private func makeButtonsContentView() -> UIView {
        let buttonsContentView = UIView()
        
        return buttonsContentView
    }
    private func makeBallView() -> UIView {
        let ballView = UIView()
        ballView.backgroundColor = .red
        ballView.clipsToBounds = true
        
        return ballView
    }
    
    // FIXME: Debug, to delete; button to switch between Question and Answer modes
    private func makeSwitchQuestionAnswerModes() -> UIButton {
        let switchQuestionAnswerModes = UIButton()
        switchQuestionAnswerModes.backgroundColor = .red
        switchQuestionAnswerModes.addTarget(self, action: #selector(switchQuestionAnswerModesTapped), for: .touchUpInside)
        return switchQuestionAnswerModes
    }
    
    private func makeQuestionTextField() -> UITextField {
        let questionTextField = UITextField()
        questionTextField.borderStyle = .roundedRect
        questionTextField.clearButtonMode = .whileEditing
        questionTextField.placeholder = "Enter question..."
        questionTextField.isHidden = false
        questionTextField.delegate = self
        questionTextField.returnKeyType = .continue
        
        return questionTextField
    }
    private func makeAnswerLabel() -> UILabel {
        let answerLabel = UILabel()
        answerLabel.numberOfLines = 0
        answerLabel.isHidden = true
        answerLabel.textAlignment = .center
        answerLabel.textColor = .white
        answerLabel.text = "Lorem ipsum"
        
        return answerLabel
    }
    private func makeClearAnswerButton() -> UIButton {
        let clearAnswerButton = UIButton()
        clearAnswerButton.backgroundColor = .systemBlue
        clearAnswerButton.layer.cornerRadius = 12.0
        clearAnswerButton.addTarget(self, action: #selector(clearAnswerButtonTapped(_:)), for: .touchUpInside)
        clearAnswerButton.isHidden = true
        
        let attributedTitle = NSAttributedString(string: "Clear Answer", attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold),
            .foregroundColor: UIColor.white
        ])
        clearAnswerButton.setAttributedTitle(attributedTitle, for: .normal)
        
        return clearAnswerButton
    }
    private func makeShareAnswerButton() -> UIButton {
        let shareAnswerButton = UIButton()
        shareAnswerButton.backgroundColor = .systemBlue
        shareAnswerButton.layer.cornerRadius = 12.0
        shareAnswerButton.addTarget(self, action: #selector(shareAnswerButtonTapped(_:)), for: .touchUpInside)
        shareAnswerButton.isHidden = true
        
        let attributedTitle = NSAttributedString(string: "Share Answer", attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold),
            .foregroundColor: UIColor.white
        ])
        shareAnswerButton.setAttributedTitle(attributedTitle, for: .normal)
        
        return shareAnswerButton
    }
    
    // MARK: - Make up view hierarchy
    
    private func setupViewHierarchy() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(ballContentView)
        contentView.addSubview(buttonsContentView)
        ballContentView.addSubview(ballView)
        
        // FIXME: Debug, to delete; button to switch between Question and Answer modes
        ballContentView.addSubview(switchQuestionAnswerModes)
        
        ballView.addSubview(questionTextField)
        ballView.addSubview(answerLabel)
        buttonsContentView.addSubview(clearAnswerButton)
        buttonsContentView.addSubview(shareAnswerButton)
    }
    
    // MARK: - Setup constraints
    
    private func constraintInterface() {
        constraintScrollView(scrollView)
        constraintContentView(contentView)
        constraintBallContentView(ballContentView)
        constraintButtonsContentView(buttonsContentView)
        constraintBallView(ballView)
        
        // FIXME: Debug, to delete; button to switch between Question and Answer modes
        constraintSwitchQuestionAnswerModes(switchQuestionAnswerModes)
        
        constraintQuestionTextField(questionTextField)
        constraintAnswerLabel(answerLabel)
        constraintClearAnswerButton(clearAnswerButton)
        constraintShareAnswerButton(shareAnswerButton)
    }
    
    private func constraintScrollView(_ scrollView: UIView) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    private func constraintContentView(_ contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, constant: 0.0)
        heightAnchor.priority = .defaultLow
        heightAnchor.isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0.0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0.0).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: 0.0).isActive = true
    }
    private func constraintBallContentView(_ ballContentView: UIView) {
        ballContentView.translatesAutoresizingMaskIntoConstraints = false
        
        ballContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        ballContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        ballContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0).isActive = true
    }
    private func constraintButtonsContentView(_ buttonsContentView: UIView) {
        buttonsContentView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsContentView.topAnchor.constraint(equalTo: ballContentView.bottomAnchor, constant: 0.0).isActive = true
        buttonsContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        buttonsContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0).isActive = true
        buttonsContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
    }
    private func constraintBallView(_ ballView: UIView) {
        ballView.translatesAutoresizingMaskIntoConstraints = false
        
        ballView.centerXAnchor.constraint(equalTo: ballContentView.centerXAnchor, constant: 0.0).isActive = true
        ballView.centerYAnchor.constraint(equalTo: ballContentView.centerYAnchor, constant: 0.0).isActive = true
        ballView.leadingAnchor.constraint(equalTo: ballContentView.leadingAnchor, constant: 35.0).isActive = true
        ballView.heightAnchor.constraint(equalTo: ballView.widthAnchor, constant: 0.0).isActive = true
    }
    
    // FIXME: Debug, to delete; button to switch between Question and Answer modes
    private func constraintSwitchQuestionAnswerModes(_ switchQuestionAnswerModes: UIView) {
        switchQuestionAnswerModes.translatesAutoresizingMaskIntoConstraints = false
        
        switchQuestionAnswerModes.trailingAnchor.constraint(equalTo: ballContentView.trailingAnchor, constant: -10.0).isActive = true
        switchQuestionAnswerModes.bottomAnchor.constraint(equalTo: ballContentView.bottomAnchor, constant: -10.0).isActive = true
        switchQuestionAnswerModes.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        switchQuestionAnswerModes.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    private func constraintQuestionTextField(_ questionTextField: UIView) {
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        questionTextField.centerXAnchor.constraint(equalTo: ballView.centerXAnchor, constant: 0.0).isActive = true
        questionTextField.centerYAnchor.constraint(equalTo: ballView.centerYAnchor, constant: 0.0).isActive = true
        questionTextField.leadingAnchor.constraint(equalTo: ballView.leadingAnchor, constant: 15.0).isActive = true
        questionTextField.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
    }
    private func constraintAnswerLabel(_ answerLabel: UIView) {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        answerLabel.centerXAnchor.constraint(equalTo: ballView.centerXAnchor, constant: 0.0).isActive = true
        answerLabel.centerYAnchor.constraint(equalTo: ballView.centerYAnchor, constant: 0.0).isActive = true
        answerLabel.widthAnchor.constraint(equalTo: answerLabel.heightAnchor, constant: 0.0).isActive = true
        
        ballView.setNeedsLayout()
        ballView.layoutIfNeeded() // force Auto Layout engine to define ballView bounds
        let distanceFromCircleToInscribedSquare = (1 - sqrt(2)/2) * ballView.bounds.height/2
        
        answerLabel.lastBaselineAnchor.constraint(equalTo: ballView.bottomAnchor, constant: -distanceFromCircleToInscribedSquare).isActive = true
    }
    private func constraintClearAnswerButton(_ clearAnswerButton: UIView) {
        clearAnswerButton.translatesAutoresizingMaskIntoConstraints = false
        
        clearAnswerButton.topAnchor.constraint(equalTo: buttonsContentView.topAnchor, constant: 0.0).isActive = true
        clearAnswerButton.leadingAnchor.constraint(equalTo: buttonsContentView.leadingAnchor, constant: 12.0).isActive = true
        clearAnswerButton.trailingAnchor.constraint(equalTo: buttonsContentView.trailingAnchor, constant: -12.0).isActive = true
        clearAnswerButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    private func constraintShareAnswerButton(_ shareAnswerButton: UIView) {
        shareAnswerButton.translatesAutoresizingMaskIntoConstraints = false
        
        shareAnswerButton.topAnchor.constraint(equalTo: clearAnswerButton.bottomAnchor, constant: 12.0).isActive = true
        shareAnswerButton.leadingAnchor.constraint(equalTo: buttonsContentView.leadingAnchor, constant: 12.0).isActive = true
        shareAnswerButton.trailingAnchor.constraint(equalTo: buttonsContentView.trailingAnchor, constant: -12.0).isActive = true
        shareAnswerButton.bottomAnchor.constraint(equalTo: buttonsContentView.bottomAnchor, constant: -12.0).isActive = true
        shareAnswerButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    // MARK: - Handle button taps
    
    @objc private func clearAnswerButtonTapped(_ sender: UIButton) {
        // FIXME: Debug, to delete
        print("clearAnswerButtonTapped")
        
        // Button tapping animation
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut) {
            sender.alpha = 0.5
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            sender.alpha = 1.0
        }
        
        questionTextField.text = nil
        questionTextField.becomeFirstResponder()
        switchQuestionAnswerModesTapped()
    }
    @objc private func shareAnswerButtonTapped(_ sender: UIButton) {
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
    
    @objc private func switchQuestionAnswerModesTapped() {
        // FIXME: Debug, to delete
        print("switchQuestionAnswerModesTapped")
        
        questionTextField.isHidden = !questionTextField.isHidden
        answerLabel.isHidden = !answerLabel.isHidden
        clearAnswerButton.isHidden = !clearAnswerButton.isHidden
        shareAnswerButton.isHidden = !shareAnswerButton.isHidden
        
        // FIXME: Debug, to delete; button to switch between Question and Answer modes
        if questionTextField.isHidden {
            switchQuestionAnswerModes.backgroundColor = .systemGreen
        } else {
            switchQuestionAnswerModes.backgroundColor = .systemRed
        }
    }
    
    // MARK: - Text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
