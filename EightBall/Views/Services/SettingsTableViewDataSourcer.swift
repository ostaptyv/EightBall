//
//  SettingsTableViewDataSourcer.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 01.02.2022.
//

import UIKit

class SettingsTableViewDataSourcer: NSObject, UITableViewDataSource {
    
    var textFieldTableViewCell: TextFieldTableViewCell!
    
    // MARK: - Sections and cells
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return .numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == .textFieldSection {
            return 1
        }
        if section == .predefinedAnswersSection {
            // FIXME: Debug; should be replaced with real data in future
            return 10
        }
        
        fatalError("Unknown section found")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == .textFieldSection {
            return textFieldTableViewCell
        }
        if indexPath.section == .predefinedAnswersSection {
            let predefinedAnswerCell = tableView.dequeueReusableCell(withIdentifier: .predefinedAnswerReuseIdentifier, for: indexPath)
            
            var contentConfiguration = predefinedAnswerCell.defaultContentConfiguration()
            contentConfiguration.text = "Placeholder"
            predefinedAnswerCell.contentConfiguration = contentConfiguration
            
            return predefinedAnswerCell
        }
        
        fatalError("Error: unknown section found")
    }
    
    // MARK: - Headers and footers
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == .predefinedAnswersSection {
            return .predefinedAnswersSectionHeader
        }
        return nil
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == .textFieldSection {
            return .textFieldSectionFooter
        }
        return nil
    }
    
    // MARK: - Editing
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if textFieldTableViewCell.isTextFieldEditing {
            // Doesn't allow the table view to edit when the user enters something in the text field
            return false
        }
        // Constraints the table view to not edit the text field cell
        return indexPath.section != .textFieldSection
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == .textFieldSection {
            return .none
        }
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Constants

fileprivate extension Int {
    static let numberOfSections = 2
    
    static let textFieldSection = 0
    static let predefinedAnswersSection = 1
}
fileprivate extension String {
    static let predefinedAnswersSectionHeader = "Predefined answers"
    static let textFieldSectionFooter = "The answers you enter here will be used in case the Internet connection is not available."
}
