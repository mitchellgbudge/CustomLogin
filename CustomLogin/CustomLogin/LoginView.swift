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
    let customBackgroundColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // MARK: - Setup
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    func createUI() {
        backgroundColor = customBackgroundColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        let textFieldContainerView = UIView()
        addSubview(textFieldContainerView)
        textFieldContainerView.backgroundColor = .clear
        textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainerView.layer.borderWidth = 2.0
        textFieldContainerView.layer.cornerRadius = 5.0
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        textFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: margin).isActive = true
        textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        textFieldContainerView.addSubview(textField)
        textField.delegate = self
        textField.tintColor = textFieldBorderColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = !showingPassword
        textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: textFieldMargin).isActive = true
        textFieldContainerView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldMargin).isActive = true
        
        textFieldContainerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin).isActive = true
        textFieldContainerView.trailingAnchor.constraint(equalTo: showHideButton.trailingAnchor, constant: textFieldMargin).isActive = true
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped(_:)), for: .touchUpInside)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.layer.cornerRadius = colorViewSize.height / 2.0

        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.layer.cornerRadius = colorViewSize.height / 2.0

        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.layer.cornerRadius = colorViewSize.height / 2.0

        let colorStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        addSubview(colorStackView)
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
        colorStackView.axis = .horizontal
        colorStackView.alignment = .fill
        colorStackView.distribution = .fill
        colorStackView.spacing = 2.0
        colorStackView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 16.0).isActive = true
        colorStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        addSubview(strengthLabel)
        strengthLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthLabel.leadingAnchor.constraint(equalTo: colorStackView.trailingAnchor, constant: margin).isActive = true
        strengthLabel.centerYAnchor.constraint(equalTo: colorStackView.centerYAnchor).isActive = true
        bottomAnchor.constraint(equalTo: strengthLabel.bottomAnchor, constant: margin).isActive = true
        strengthLabel.text = "Too weak"
        strengthLabel.font = labelFont
        strengthLabel.textColor = labelTextColor
    }
    
    
    // MARK: - Helper Functions
    
    @objc func showHideButtonTapped(_ sender: UIButton) {
        showingPassword.toggle()
        showHideButton.setImage(UIImage(named: (showingPassword) ? "eyes-open" : "eyes-closed"), for: .normal)
        textField.isSecureTextEntry = !showingPassword
    }
    
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
        self.strength = strength
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
