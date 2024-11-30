import XCTest
import UIKit
@testable import KCDragonBallProf

class UIImageViewExtensionTests: XCTestCase {
    
    func testLoadImageRemoteSuccess() {
        // Given
        let imageView = UIImageView()
        let expectation = self.expectation(description: "Imagen cargada correctamente")
        guard let url = URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300") else {
            XCTFail("URL inválida")
            return
        }
        
        // Simular datos de imagen
        let dummyImage = UIImage(systemName: "star")!
        let dummyData = dummyImage.pngData()!
        URLProtocolMock.testData = dummyData
        
        // When
        URLProtocolMock.startInterceptingRequests()
        imageView.loadImageRemote(url: url)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertNotNil(imageView.image, "La imagen no fue cargada en UIImageView")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        URLProtocolMock.stopInterceptingRequests()
    }
}
