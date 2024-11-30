import XCTest
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
        
        // Espera a que la imagen se cargue
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Then
            // Verifica que la imagen no es nil
            XCTAssertNotNil(imageView.image, "La imagen no fue cargada en UIImageView")
            expectation.fulfill() // Fulfills the expectation after the image is set
        }
        
        // Espera un tiempo para que se complete la carga de la imagen
        wait(for: [expectation], timeout: 3)
        
        // Detiene la interceptación de solicitudes
        URLProtocolMock.stopInterceptingRequests()
    }
}
