//
//  SettingsViewController.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 29.01.2022.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    private let textFieldTableViewCell = TextFieldTableViewCell(style: .default, reuseIdentifier: .textFieldCellReuseIdentifier)
    
    // MARK: - View controller lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - Setup UI
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Settings"
    }
    private func setupTableView() {
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 45
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: .textFieldCellReuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .predefinedAnswerReuseIdentifier)
    }
    
    // MARK: - Text field delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.setEditing(false, animated: true)
        self.setEditing(false, animated: true)
        
        tableView.isKeyboardDismissedWhenTappedOutside = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // FIXME: Should send the text field string to ViewModel here...
        
        tableView.isKeyboardDismissedWhenTappedOutside = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        // FIXME: Debug, to delete
        print("User entered new answer! Answer: \"\(textField.text ?? "*nil string*")\", reason: \(String(describing: reason))")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // FIXME: Should send the text field string to ViewModel here...
        
        textField.text = nil
        return textField.resignFirstResponder()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            // FIXME: Debug; should be replaced with real data in future
            return 10
        }
        
        fatalError("Unknown section found")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if textFieldTableViewCell.textFieldDelegate == nil {
                textFieldTableViewCell.textFieldDelegate = self
            }
            
            return textFieldTableViewCell
        }
        if indexPath.section == 1 {
            let predefinedAnswerCell = tableView.dequeueReusableCell(withIdentifier: .predefinedAnswerReuseIdentifier, for: indexPath)
            
            var contentConfiguration = predefinedAnswerCell.defaultContentConfiguration()
            contentConfiguration.text = "Placeholder"
            predefinedAnswerCell.contentConfiguration = contentConfiguration
            
            return predefinedAnswerCell
        }
        
        fatalError("Error: unknown section found")
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Predefined answers"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "The answers you enter here will be used in case the Internet connection is not available."
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if textFieldTableViewCell.isTextFieldEditing {
            // Doesn't allow the table view to edit when the user enters something in the text field
            return false
        }
        
        // Constraints the table view to not edit the text field cell
        return indexPath.section != 0
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .none
        }
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Table view delegate
    
    // Disables highlighting cells in the table view
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // Disables selecting cells in the table view
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

// MARK: - Constants
fileprivate extension String {
    static let textFieldCellReuseIdentifier = String(describing: TextFieldTableViewCell.self)
    static let predefinedAnswerReuseIdentifier: String = "PredefinedAnswerTableViewCell"
}
