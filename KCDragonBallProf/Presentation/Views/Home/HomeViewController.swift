//
//  HeroesListViewController.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 25/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var appState: AppState?
    
    init(appState: AppState) {
        self.appState = appState
        super.init(nibName: String(describing: HomeViewController.self), bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func closeSession(_ sender: UIButton) {
        self.appState?.closeSessionUser()
    }
    
    

}
