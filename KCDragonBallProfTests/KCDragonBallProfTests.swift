//
//  KCDragonBallProfTests.swift
//  KCDragonBallProfTests
//
//  Created by Kevin Heredia on 20/11/24.
//

import XCTest
import Combine
import KeychainSwift
import CombineCocoa
import UIKit
@testable import KCDragonBallProf

final class KCDragonBallProfTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKeyChainLibrary() throws {
        let keyChain = KeychainSwift()
        XCTAssertNotNil(keyChain)
        
        let save = keyChain.set("Test", forKey: "123")
        XCTAssertEqual(save, true)
        
        
        let value = keyChain.get("Test")
        if let valor = value {
            XCTAssertEqual(valor, "123")
        }
        
        
        XCTAssertNoThrow(keyChain.delete("Test"))
    }
    
    func testLoginFake() async throws {
        let keyChain = KeychainSwift()
        XCTAssertNotNil(keyChain)
        
        let obj = LoginUseCaseFake()
        XCTAssertNotNil(obj)
        
        //Valida el Token
        let resp = await obj.validateToken()
        XCTAssertEqual(resp, true)
        
        //Login
        let LoginDo = await obj.loginApp(user: "", password: "")
        XCTAssertEqual(LoginDo, true)
        var jwt = keyChain.get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //Close Session
        await obj.logout()
        jwt = keyChain.get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, nil)
    }

    func testLoginReal() async throws {
        let keyChain = KeychainSwift()
        XCTAssertNotNil(keyChain)
        
        //reset the token
        keyChain.set(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, forKey: "")
        
        //Caso de uso con repo Fake
        let useCase = LoginUseCase(repo: LoginRepositoryFake())
        XCTAssertNotNil(useCase)
        
        //validacion
        let resp = await useCase.validateToken()
        XCTAssertEqual(resp, false)
        
        //login
        let loginDo = await useCase.loginApp(user: "", password: "")
        XCTAssertEqual(loginDo, true)
        var jwt = keyChain.get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //Close Session
        await useCase.logout()
        jwt = keyChain.get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, nil)
    }
    
    
    func testLoginAutoLoginAsincrono() throws {
        var suscriptor = Set<AnyCancellable>()
        let exp = self.expectation(description: "Login Auto")
        
        let viewModel = AppState(loginUseCase: LoginUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        viewModel.$statusLogin
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("finalizado")
                }
            } receiveValue: { estado in
                print("Recibo estado \(estado)")
                if estado == .success {
                    exp.fulfill()
                }
            }
            .store(in: &suscriptor)
        
        viewModel.validateControlLogin()
        self.waitForExpectations(timeout: 10)

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
        XCTAssertEqual(viewModel.herosData.count, 15) //debe haber 2 heroes fake mokeados
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
        let exp = self.expectation(description: "Heroes get")
        
        let viewModel = HeroesViewModel(usecaseHeroes: HeroesUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        
        viewModel.$herosData
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
        await self.waitForExpectations(timeout: 10)

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
