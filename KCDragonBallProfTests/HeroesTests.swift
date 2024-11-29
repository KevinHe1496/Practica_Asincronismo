//
//  HeroesTests.swift
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

final class HeroesTests: XCTestCase {
    
    
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
    
    func testHeroViewModel() async throws {
        let viewModel = HeroesViewModel(usecaseHeroes: HeroesUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        let expectation = self.expectation(description: "Get Heroes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.herosData.count, 15) //debe haber 15 heroes fake mokeados
    }
    
    func testHeroesUsecase() async throws {
        let caseUser = HeroesUseCase(repo: HeroesRepositoryFake())
        XCTAssertNotNil(caseUser)
        
        let data = await caseUser.getHeroes(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 15)
    }
    
    func testHeroes_Combine() async throws {
        
        var suscriptor = Set<AnyCancellable>()
        let exp = self.expectation(description: "Get Heroes")
        
        let viewModel = HeroesViewModel(usecaseHeroes: HeroesUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        
        viewModel.$herosData
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("finalizado")
                }
            } receiveValue: { heroes in
                if heroes.count == 15 {
                    exp.fulfill()
                }
            }
            .store(in: &suscriptor)
        wait(for: [exp], timeout: 5)

    }
    
    func testHeroes_Data() async throws {
        let network = NetworkHeroesFake()
        XCTAssertNotNil(network)
        let repo = HeroesRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = HeroesRepositoryFake()
        XCTAssertNotNil(repo2)
        
        let data = await repo.getHeroes(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 15)
        
        let data2 = await repo2.getHeroes(filter: "")
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count, 15)
    }
    
    
    func testHeores_Domain() async throws {
        let model = HeroesModel(id: UUID(), favorite: true, description: "des", photo: "url", name: "goku")
        XCTAssertNotNil(model)
        XCTAssertEqual(model.name, "goku")
        XCTAssertEqual(model.favorite, true)
        XCTAssertEqual(model.photo, "url")
        XCTAssertEqual(model.description, "des")
        
        
        let requestModel = HeroModelRequest(name: "goku")
        XCTAssertNotNil(requestModel)
        XCTAssertEqual(requestModel.name, "goku")
    }
    
    func testHeroes_Presentation() async throws {
        let viewModel = HeroesViewModel(usecaseHeroes: HeroesUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        let view = await HeroesListViewController(appState: AppState(loginUseCase: LoginUseCaseFake()), viewModel: viewModel)
        XCTAssertNotNil(view)
    }
}
