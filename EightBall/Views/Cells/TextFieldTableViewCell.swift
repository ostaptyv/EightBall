//
//  TextFieldTableViewCell.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 29.01.2022.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Public interface
    
    public var textFieldDelegate: UITextFieldDelegate? {
        get {
            return textField.delegate
        }
        set {
            textField.delegate = newValue
        }
    }
    public var isTextFieldEditing: Bool {
        return textField.isEditing
    }
    
    // MARK: - Private properties and methods
    
    private var textField: UITextField!
    
    // MARK: Initialization entry point

    private func setupCell() {
        setupTextField()
    }
    
    private func setupTextField() {
        // Initialize
        textField = UITextField()
        textField.placeholder = "Enter predefined answer..."
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        
        // Add to view hierarchy
        contentView.addSubview(textField)
        
        // Constraint
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
}
