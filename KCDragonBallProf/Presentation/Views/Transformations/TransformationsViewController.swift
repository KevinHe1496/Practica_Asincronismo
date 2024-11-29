import UIKit
import Combine
import CombineCocoa

class TransformationsViewController: UITableViewController {
    
    private var appState: AppState?
    private var viewModel: TransformationsViewModel
    var suscriptors = Set<AnyCancellable>()
    
    private var isAlertPresented = false  // Controlar si la alerta se ha mostrado
    
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
        self.title = "Transformaciones"
        self.bindingUI()
    }

    private func bindingUI() {
        // Observamos el estado de isLoading y transformationsData
        self.viewModel.$transformationsData
            .combineLatest(self.viewModel.$isLoading)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transformations, isLoading in
                guard let self = self else { return }
                
                if !isLoading {  // Si los datos ya se cargaron
                    if transformations.isEmpty && !self.isAlertPresented {
                        self.isAlertPresented = true
                        
                        // Mostrar la alerta si la lista está vacía
                        let alert = UIAlertController(title: "No hay transformaciones",
                                                      message: "Actualmente no hay transformaciones disponibles para este héroe.",
                                                      preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "OK", style: .default) { _ in
                            self.isAlertPresented = false
                            
                            // Volver a la vista anterior cuando se presiona "OK"
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        // Recargar la tabla si hay datos
                        self.tableView.reloadData()
                    }
                }
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
