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
    private var viewModel: HeroesViewModel
    var suscriptors = Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: HeroesViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: String(describing: HeroesListViewController.self), bundle: Bundle(for: type(of: self)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: HeroViewCell.identifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: HeroViewCell.identifier)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSession))
        self.title = "Lista de Heroes"
        self.bindingUI()
        
        
    }
    
    @objc func closeSession() {
        NSLog("Tap in close session Button")
        self.appState?.closeSessionUser()
    }
    
    private func bindingUI() {
        self.viewModel.$herosData
            .receive(on: DispatchQueue.main)
            .sink { heroes in
                self.tableView.reloadData()
            }
            .store(in: &suscriptors)
    }
}

extension HeroesListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.herosData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroViewCell.identifier, for: indexPath) as! HeroViewCell
        
        let hero = self.viewModel.herosData[indexPath.row]
        
        cell.nameLabel.text = hero.name
        
        guard let photoURL = URL(string: hero.photo) else {
            return UITableViewCell()
        }
        
        cell.photoImageView.loadImageRemote(url: photoURL)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let hero = self.viewModel.herosData[indexPath.row]
//        print("Hero seleccionado: \(hero)")
        
        
        
        navigationController?.pushViewController(TransformationsViewController(appState: AppState(), viewModel: TransformationsViewModel(heroesId: hero)), animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

