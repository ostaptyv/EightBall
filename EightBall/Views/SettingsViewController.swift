//
//  SettingsViewController.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 29.01.2022.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    private let textFieldTableViewCell = TextFieldTableViewCell(style: .default, reuseIdentifier: nil)
    private let dataSourcer = SettingsTableViewDataSourcer()
    
    // MARK: - View controller lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTextFieldTableViewCell()
        setupTableView()
    }
    
    // MARK: - Setup UI
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Settings"
    }
    private func setupTextFieldTableViewCell() {
        textFieldTableViewCell.textFieldDelegate = self
    }
    private func setupTableView() {
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        
        dataSourcer.textFieldTableViewCell = textFieldTableViewCell
        tableView.dataSource = self.dataSourcer
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .predefinedAnswerReuseIdentifier)
    }
    
    // MARK: - Text field delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switchToInputMode(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switchToInputMode(false)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // FIXME: Should send the text field string to Presenter here...
        
        // FIXME: Debug, to delete
        print("User entered new answer! Answer: \"\(textField.text ?? "*nil string*")\"")
        
        textField.text = nil
        return textField.resignFirstResponder()
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
    
    // MARK: - Private methods
    
    private func switchToInputMode(_ isInputMode: Bool) {
        if isInputMode {
            self.setEditing(false, animated: true)
            tableView.setEditing(false, animated: true)
        }
        tableView.isKeyboardDismissedWhenTappedOutside = isInputMode
        navigationItem.rightBarButtonItem?.isEnabled = !isInputMode
    }
}

// MARK: - Constants

extension String {
    static let predefinedAnswerReuseIdentifier: String = "PredefinedAnswerTableViewCell"
}
