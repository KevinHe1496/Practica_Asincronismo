//
//  LoginViewController.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 25/11/24.
//

import UIKit
import Combine
import CombineCocoa


class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var appState: AppState?
    private var user: String = ""
    private var pass: String = ""
    private var subscriptions = Set<AnyCancellable>()
    
    init(appState: AppState) {
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.placeholder = NSLocalizedString("Email", comment: "Email del usuario")
        passwordTextField.placeholder = NSLocalizedString("Password", comment: "Password del usuario")
        bindingUI()

    }

    @IBAction func loginButton(_ sender: Any) {
        
    }
    
    private func bindingUI() {
        if let userTextfield = self.userTextField {
            userTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] userText in
                    if let user = userText {
                        print("Text user: \(user)")
                        self?.user = user
                        
                        if let button = self?.loginButton {
                            if (self?.user.count)! > 5 {
                                button.isEnabled = true
                            } else {
                                button.isEnabled = false
                            }
                        }
                    }
                }.store(in: &subscriptions)
        }
        
        if let passwordTextField = self.passwordTextField {
            passwordTextField.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] passwordText in
                    if let password = passwordText {
                        print("Text password: \(password)")
                        self?.pass = password
                    }
                }
                .store(in: &subscriptions)
        }
        
        if let button = self.loginButton {
            button.tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    if let user = self?.user,
                       let pass = self?.pass {
                        self?.appState?.loginApp(user: user, pass: pass)
                        
                    }
                }.store(in: &subscriptions)
        }
    }
    
}
