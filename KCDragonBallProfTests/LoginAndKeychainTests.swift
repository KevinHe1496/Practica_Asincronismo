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

final class LoginAndKeychainTests: XCTestCase {

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
    
    func testUILoginView() throws {
        
        XCTAssertNoThrow(LoginViewController(appState: AppState()))
        let view = LoginViewController(appState: AppState())
        XCTAssertNotNil(view)
        
        guard let txtUser = view.userTextField else {
            return
        }
        XCTAssertNotNil(txtUser)
        
        guard let txtPass = view.passwordTextField else {
            return
        }
        XCTAssertNotNil(txtPass)
        
        guard let button = view.loginButton else {
            return
        }
        XCTAssertNotNil(button)
        
        
        XCTAssertEqual(txtUser.placeholder, "E-mail")
        XCTAssertEqual(txtPass.placeholder, "Password")
        XCTAssertEqual(button.titleLabel?.text, "Login")
        
    }
    
    
    
}
