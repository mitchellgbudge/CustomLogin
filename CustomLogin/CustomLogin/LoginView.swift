//
//  LoginView.swift
//  CustomLogin
//
//  Created by Mitchell Budge on 11/11/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class LoginView: UIControl {

    // MARK: - Properties
    var password: String = ""
    var strength: Strength = .weak
    var showingPassword = false
    
    // MARK: - UI
    var titleLabel: UILabel = UILabel()
    var textField: UITextField = UITextField()
    var showHideButton: UIButton = UIButton()
    var weakView: UIView = UIView()
    var mediumView: UIView = UIView()
    var strongView: UIView = UIView()
    var strengthLabel: UILabel = UILabel()
    
    // MARK: - UISizes & Margins
    let margin: CGFloat = 8.0
    let textFieldContainerHeight: CGFloat = 50.0
    let textFieldMargin: CGFloat = 6.0
    let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    // MARK: - Colors
    let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // MARK: - Setup
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    func createUI() {
        
    }
    
    
    // MARK: - Helper Functions
    func determineStrength(text: String) {
        var strength = Strength.weak
        switch text.count {
        case 0...9:
            strength = .weak
        case 10...19:
            strength = .medium
        default:
            strength = .strong
        }
        updateViews(strength: strength)
    }
    
    func updateViews(strength: Strength) {
        
    }
    
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let originalText = textField.text!
        let textRange = Range(range, in: originalText)!
        let replacedText = originalText.replacingCharacters(in: textRange, with: string)
        determineStrength(text: replacedText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            password = text
        }
        sendActions(for: .valueChanged)
    }
}
