//
//  SignInViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 3/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SafariServices
import SkyFloatingLabelTextField
import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    var emailTextField = UITextField()
    var passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "MyClipper"
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
    }

    func setupView() {
        emailTextField = customTextField(placeholder: "E-mail")
        emailTextField.addTarget(self, action: #selector(validateEmail(_:)), for: .editingChanged)
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(30)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(56)
        }
        emailTextField.becomeFirstResponder()

        passwordTextField = customTextField(placeholder: "Password")
        passwordTextField.delegate = self
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(56)
        }

        let forgotButton = UIButton()
        forgotButton.setTitle("Forgot your password?", for: .normal)
        forgotButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        forgotButton.setTitleColor(UIColor(hex: 0x007AFF), for: .normal)
        forgotButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        view.addSubview(forgotButton)
        forgotButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(15)
            make.centerX.equalToSuperview()
        }

        let logInButton = BayPassButton(title: "Log in", color: UIColor().clipperBlue)
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        view.addSubview(logInButton)
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotButton.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(50)
        }
    }

    func customTextField(placeholder: String) -> UITextField {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        textField.selectedTitleColor = UIColor(hex: 0xA4A4A4)
        return textField
    }

    @objc func validateEmail(_ textField: UITextField) {
        // Detect email autoFill which adds a space at the end
        // We then trim the space and make the password text field first responder
        if textField.text?.last == " " {
            textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            passwordTextField.becomeFirstResponder()
        }

        if let text = textField.text,
            let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
            if text.count < 3 || !text.contains("@") || !text.contains(".") {
                floatingLabelTextField.errorMessage = "Invalid email"
            } else {
                floatingLabelTextField.errorMessage = ""
            }
        }
    }

    @objc func forgotPassword() {
        let safariVC = SFSafariViewController(url: URL(string: "https://m.clippercard.com/ClipperCard/forgottenPassword.jsf")!)
        present(safariVC, animated: true, completion: nil)
    }

    @objc func logIn() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            email != "",
            password != "",
            (emailTextField as? SkyFloatingLabelTextField)?.errorMessage == ""
        else {
            displayAlert(title: "Invalid", msg: "Double check that you filled all fields and they are valid", dismissAfter: false)
            return
        }

        let progressHUD = ProgressHUD()
        view.addSubview(progressHUD)

        fetchClipperData(email: email, password: password, completion: {
            progressHUD.stop()
            guard let newCard = $0?.first else {
                self.displayAlert(title: "Error", msg: "We could not fetch any cards for this account. Double check your credentials.", dismissAfter: false)
                return
            }
            clipperManager.setClipperCard(card: newCard)
            self.dismissOrPop(animated: true)
        })
    }
}
