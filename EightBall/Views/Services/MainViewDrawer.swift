//
//  MainViewDrawer.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 31.01.2022.
//

import UIKit

class MainViewDrawer {
    
    // MARK: - Public interface
    private(set) var scrollView: UIScrollView!
    private(set) var contentView: UIView!
    private(set) var ballContentView: UIView!
    private(set) var buttonsContentView: UIView!
    private(set) var ballView: UIView!
    
    // FIXME: Debug, to delete; button to switch between Question and Answer modes
    private(set) var switchQuestionAnswerModes: UIButton!
    
    private(set) var questionTextField: UITextField!
    private(set) var answerLabel: UILabel!
    private(set) var clearAnswerButton: UIButton!
    private(set) var shareAnswerButton: UIButton!
    
    private(set) var isInitialized = false
    public weak var delegate: MainViewDrawerDelegate?
    
    // MARK: Drawing entry point
    
    public func setupInterface() {
        if isInitialized {
            print("Warning: The drawer's \(#function) should be called once and only once! Otherwise, behavior is undefined: file \(#file), line \(#line)")
            return
        }
        
        if let strongReferenceDelegate = self.delegate {
            initializeInterface()
            setupViewHierarchy(using: strongReferenceDelegate)
            constraintInterface(using: strongReferenceDelegate)
            
            isInitialized = true
        } else {
            fatalError("At the moment of calling \(#function) delegate should not be nil")
        }
    }
    
    // MARK: - Initialize UI
    
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
        questionTextField.returnKeyType = .continue
        questionTextField.delegate = self.delegate!
        
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
    
    private func setupViewHierarchy(using delegate: MainViewDrawerDelegate) {
        delegate.addSubviewToHostingView(scrollView)
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
    
    private func constraintInterface(using delegate: MainViewDrawerDelegate) {
        constraintScrollView(scrollView, using: delegate)
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
    
    private func constraintScrollView(_ scrollView: UIView, using delegate: MainViewDrawerDelegate) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: delegate.hostingViewSafeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: delegate.hostingViewSafeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: delegate.hostingViewSafeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: delegate.hostingViewSafeAreaLayoutGuide.trailingAnchor).isActive = true
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
    
    // MARK: - Call delegate methods
    
    @objc private func clearAnswerButtonTapped(_ sender: UIButton) {
        self.delegate?.clearAnswerButtonTapped?(sender)
    }
    @objc private func shareAnswerButtonTapped(_ sender: UIButton) {
        self.delegate?.shareAnswerButtonTapped?(sender)
    }
    
    // FIXME: Debug, to delete
    @objc private func switchQuestionAnswerModesTapped() {
        self.delegate?.switchQuestionAnswerModesTapped?()
    }
}
