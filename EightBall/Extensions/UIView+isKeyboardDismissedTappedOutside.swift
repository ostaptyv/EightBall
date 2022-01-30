//
//  UIView+isKeyboardDismissedTappedOutside.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 29.01.2022.
//

import UIKit

fileprivate var tapGestureRecognizers = NSMapTable<UIView, UITapGestureRecognizer>(keyOptions: .weakMemory, valueOptions: .weakMemory)

extension UIView {
    
    /// A Boolean value that determines whether the keyboard will be dismissed when the user taps on the view.
    ///
    /// Usually you use this property when you want to hide your keyboard each time user taps anywhere on screen outside the area of the keyboard. The view has to be reachable outside the area of the keyboard, so it's recommended to use this property on the view of your view controller:
    ///
    ///     func viewDidLoad() {
    ///         super.viewDidLoad()
    ///
    ///         self.view.isKeyboardDismissedWhenTappedOutside = true
    ///     }
    ///
    public var isKeyboardDismissedWhenTappedOutside: Bool {
        get {
            return tapGestureRecognizers[self] != nil
        }
        set(keyboardShouldDismiss) {
            if self.isKeyboardDismissedWhenTappedOutside == keyboardShouldDismiss {
                return
            }
            manageTapGestureRecognizer(using: keyboardShouldDismiss, for: self)
        }
    }
    
    private func manageTapGestureRecognizer(using keyboardShouldDismiss: Bool, for target: UIView) {
        if keyboardShouldDismiss {
            let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: #selector(dismissKeyboard))
            
            addGestureRecognizer(tapGestureRecognizer)
            tapGestureRecognizers[target] = tapGestureRecognizer
            
        } else {
            guard let unwrappedTapGestureRecognizer = tapGestureRecognizers[target] else {
                return
            }
            removeGestureRecognizer(unwrappedTapGestureRecognizer)
            tapGestureRecognizers[target] = nil
        }
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}

fileprivate extension NSMapTable where KeyType == UIView, ObjectType == UITapGestureRecognizer {
    subscript(key: KeyType) -> ObjectType? {
        get {
            return object(forKey: key)
        }
        set {
            if newValue != nil {
                setObject(newValue, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
