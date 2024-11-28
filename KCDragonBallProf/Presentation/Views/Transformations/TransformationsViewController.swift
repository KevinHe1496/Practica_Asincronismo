//
//  TransformationsViewController.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 28/11/24.
//

import UIKit
import Combine
import CombineCocoa

class TransformationsViewController: UITableViewController {
    
    private var appState: AppState?
    private var viewModel: TransformationsViewModel
    var suscriptors = Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: TransformationsViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: String(describing: TransformationsViewController.self), bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: TransformationsViewCell.identifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: TransformationsViewCell.identifier)
        self.title = viewModel.transformationsData.first?.name
        self.bindingUI()

    }

    private func bindingUI() {
        self.viewModel.$transformationsData
            .receive(on: DispatchQueue.main)
            .sink { transformations in
                self.tableView.reloadData()
            }
            .store(in: &suscriptors)
    }
    
}

extension TransformationsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.transformationsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransformationsViewCell.identifier, for: indexPath) as! TransformationsViewCell
        
        let transformation = self.viewModel.transformationsData[indexPath.row]
        cell.transfNameLabel.text = transformation.name
        
        guard let photoURL = URL(string: transformation.photo) else {
            return UITableViewCell()
        }
        
        cell.transformationImageView.loadImageRemote(url: photoURL)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
