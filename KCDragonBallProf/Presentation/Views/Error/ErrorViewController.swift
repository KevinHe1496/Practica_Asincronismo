//
//  ErrorViewController.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 25/11/24.
//

import UIKit
import Combine
import CombineCocoa


class ErrorViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var appState: AppState?
    private var suscriptor = Set<AnyCancellable>()
    private var error: String?
    
    init(appState: AppState, error: String) {
        self.appState = appState
        self.error = error
        super.init(nibName: String(describing: ErrorViewController.self), bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorLabel.text = self.error
        self.backButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.appState?.statusLogin = .none
            }.store(in: &suscriptor)
    }
    
}
