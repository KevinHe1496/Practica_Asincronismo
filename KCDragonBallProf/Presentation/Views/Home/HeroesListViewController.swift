//
//  HeroesListViewController.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 26/11/24.
//

import UIKit
import Combine

class HeroesListViewController: UITableViewController {
    
    private var appState: AppState?
    private var viewModel: HeroesViewModel?
    var suscriptors = Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: HeroesViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: String(describing: HeroesListViewController.self), bundle: Bundle(for: type(of: self)))
        self.title = "Lista de Heroes"
        self.bindingUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSession))

    }
    
    @objc func closeSession() {
        NSLog("Tap in close session Button")
        self.appState?.closeSessionUser()
    }
    
    private func bindingUI() {
        self.viewModel?.$herosData
            .receive(on: DispatchQueue.main)
            .sink { heroes in
                self.tableView.reloadData()
            }
            .store(in: &suscriptors)
    }


}
