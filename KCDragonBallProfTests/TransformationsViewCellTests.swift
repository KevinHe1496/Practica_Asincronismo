import XCTest
@testable import KCDragonBallProf

final class TransformationsViewCellTests: XCTestCase {
    
    var cell: TransformationsViewCell!
    
    override func setUp() {
        super.setUp()
        // Carga la celda desde el nib
        let nib = UINib(nibName: "TransformationsViewCell", bundle: nil)
        cell = nib.instantiate(withOwner: nil, options: nil).first as? TransformationsViewCell
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testCellHasCorrectIdentifier() {
        XCTAssertEqual(TransformationsViewCell.identifier, "TransformationsViewCell")
    }

    func testCellLabelIsConfiguredCorrectly() {
        // Simula la configuración del label
        let testName = "Super Saiyan"
        cell.transfNameLabel.text = testName
        XCTAssertEqual(cell.transfNameLabel.text, testName)
    }

    func testImageViewIsNotNil() {
        XCTAssertNotNil(cell.transformationImageView, "La imagen de transformación no debería ser nula")
    }
}
