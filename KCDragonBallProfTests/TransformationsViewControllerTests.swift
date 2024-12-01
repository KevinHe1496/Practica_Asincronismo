import XCTest
@testable import KCDragonBallProf

final class TransformationsViewControllerTests: XCTestCase {
    
    var viewController: TransformationsViewController!
    var mockViewModel: TransformationsViewModel!
    
    override func setUp() {
        super.setUp()
        
        // Simulación de datos de transformaciones
        let heroID = HeroModel(id: "id")
        let hero = HeroesModel(id: UUID(), favorite: false, description: "Description", photo: "Photo", name: "Goku")
        let mockTransformations = [
            TransformationModel(name: "Sayayin", description: "Description", photo: "Photo", hero: heroID)
        ]
        
        // Configurar el ViewModel simulado
        mockViewModel = TransformationsViewModel(heroesId: hero)
        mockViewModel.transformationsData = mockTransformations
        
        // Inicializar el ViewController con el ViewModel simulado
        viewController = TransformationsViewController(appState: AppState(), viewModel: mockViewModel)
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
        XCTAssertEqual(numberOfRows, 1, "El número de filas debe ser igual al número de transformaciones en el ViewModel.")
    }
    
    // Test: Verificar que la celda se configura correctamente
    func testCellForRowAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath) as! TransformationsViewCell
        
        XCTAssertEqual(cell.transfNameLabel.text, "Sayayin", "El nombre de la transformación en la celda debe coincidir con el nombre del modelo.")
    }
    
}
