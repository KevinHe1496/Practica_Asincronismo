//
//  SplashViewController.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 30/11/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    private var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SplashViewController.self), bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }
    
    private func bind() {
        viewModel.onStateChange.bind { [weak self] state in
            switch state {
                
            case .loading:
                self?.spinner.startAnimating()
            case .success:
                self?.spinner.stopAnimating()
            case .error:
                self?.spinner.stopAnimating()
            }
        }
    }

}
