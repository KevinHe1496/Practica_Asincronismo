import XCTest
@testable import KCDragonBallProf

final class HeroesListViewControllerTests: XCTestCase {
    
    var viewController: HeroesListViewController!
    var mockViewModel: HeroesViewModel!

    override func setUp() {
        super.setUp()
        
        // Simular datos de héroes
        let mockHeroesData = [
            HeroesModel(id: UUID(), favorite: false, description: "description", photo: "photo", name: "Goku"),
            HeroesModel(id: UUID(), favorite: false, description: "description", photo: "photo", name: "Krilin")
        ]
        
        // Configurar el ViewModel simulado
        mockViewModel = HeroesViewModel()
        mockViewModel.herosData = mockHeroesData
        
        // Inicializar el ViewController con el ViewModel simulado
        viewController = HeroesListViewController(appState: AppState(), viewModel: mockViewModel)
        _ = viewController.view  // Forzar la carga de la vista
    }
    
    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        super.tearDown()
    }

    // Test: Verificar que el número de filas es correcto
    func testNumberOfRowsInTableView() {
        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2, "El número de filas debe ser igual al número de héroes en el ViewModel.")
    }
    
    // Test: Verificar que la celda se configura correctamente
    func testCellForRowAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath) as! HeroViewCell
        
        XCTAssertEqual(cell.nameLabel.text, "Goku", "El nombre en la celda debe coincidir con el nombre del héroe.")
    }
    
}
