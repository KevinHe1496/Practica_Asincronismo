//
//  TransformationsTests.swift
//  KCDragonBallProfTests
//
//  Created by Kevin Heredia on 29/11/24.
//

import XCTest
import Combine
import KeychainSwift
import CombineCocoa
import UIKit
@testable import KCDragonBallProf

final class TransformationsTests: XCTestCase {

    
    override func setUpWithError() throws {

    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testUIErrorView() async throws {
        let appStateVM = AppState(loginUseCase: LoginUseCaseFake())
        XCTAssertNotNil(appStateVM)
        
        appStateVM.statusLogin = .error
        
        let vc = await ErrorViewController(appState: appStateVM, error: "Error Testing")
        XCTAssertNotNil(vc)
    }
    
    func testTransformationViewModel() async throws {
        
        let hero = HeroesModel(id: UUID(uuidString: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")!, favorite: false, description: "description", photo: "photo", name: "krilin")
        
        let useCaseFake = TransformationsUseCaseFake()
        let viewModel = TransformationsViewModel(heroesId: hero, transformationsUseCase: useCaseFake)
        
        
        let expectation = self.expectation(description: "Get Transformations")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.transformationsData.count, 4)
    }
    
    func testTransformationsUsecase() async throws {
        let caseUser = TransformationsUseCase(repo: TransformationsRepositoryFake())
        XCTAssertNotNil(caseUser)
        
        let data = await caseUser.getTransformation(id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 4)
    }
    
    func testTransformations_Combine() async throws {
        
        var suscriptor = Set<AnyCancellable>()
        let expectation = self.expectation(description: "Get Transformations")
        let hero = HeroesModel(id: UUID(uuidString: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")!, favorite: false, description: "description", photo: "photo", name: "krilin")
        let useCaseFake = TransformationsUseCaseFake()
        
        let viewModel = TransformationsViewModel(heroesId: hero, transformationsUseCase: useCaseFake)
        XCTAssertNotNil(viewModel)
        
        viewModel.$transformationsData
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("finalizado")
                }
            } receiveValue: { transformations in
                if transformations.count == 4 {
                    expectation.fulfill()
                }
            }
            .store(in: &suscriptor)
        wait(for: [expectation], timeout: 5)

    }
    
    func testTransformations_Data() async throws {
        let network = NetworkTransformationsFake()
        XCTAssertNotNil(network)
        let repo = TransformationsRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = TransformationsRepositoryFake()
        XCTAssertNotNil(repo2)
        
        let data = await repo.getTransformation(id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 4)
        
        let data2 = await repo2.getTransformation(id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count, 4)
    }
    
    func testTransformations_Domain() async throws {
        
        let hero = HeroModel(id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")
        
        let model = TransformationModel(name: "krilin", description: "description", photo: "photo", hero: hero)
        XCTAssertNotNil(model)
        XCTAssertEqual(model.name, "krilin")
        XCTAssertEqual(model.description, "description")
        XCTAssertEqual(model.photo, "photo")
        XCTAssertEqual(model.hero.id, "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")
        
        let requestModel = HeroModel(id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")
        XCTAssertNotNil(requestModel)
        XCTAssertEqual(requestModel.id, "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")
        
    }
    
    func testTransformations_Presentation() async throws {
        
        let hero = HeroesModel(id: UUID(uuidString: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")!, favorite: false, description: "description", photo: "photo", name: "krilin")
        let useCaseFake = TransformationsUseCaseFake()
        
        let viewModel = TransformationsViewModel(heroesId: hero, transformationsUseCase: useCaseFake)
        
        let view = await TransformationsViewController(appState: AppState(loginUseCase: LoginUseCaseFake()), viewModel: viewModel)
        XCTAssertNotNil(view)
    }
    
    
    
    func testLoadTransformationsError() async {
        // Given
        let hero = HeroesModel(id: UUID(uuidString: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3")!, favorite: false, description: "description", photo: "photo", name: "krilin")
        let repository = TransformationsRepositoryFake()
        let viewModel = TransformationsViewModel(heroesId: hero, transformationsUseCase: TransformationsUseCaseFakeError(repo: repository))
        
        XCTAssertNotNil(viewModel)
        
        // When
        let transformations = viewModel.transformationsData
        
        // Then
        XCTAssertTrue(transformations.isEmpty, "Se esperaba que la lista de transformaciones estuviera vacía.")
    }
    
    func testGetTransformationFromJson() async {
        
            let fakeNetwork = NetworkTransformationsFake()
            let transformations = await fakeNetwork.getTransformation(id: "testID")
            
            XCTAssertFalse(transformations.isEmpty, "La lista de transformaciones debería contener datos")
            XCTAssertEqual(transformations.first?.name, "4. Gorilin")
        XCTAssertEqual(transformations.first?.description, "Es la fusión de  Krillin y Kid Goku que apareció por primera vez en Dragon Ball Fusions.")
        }

    
}
