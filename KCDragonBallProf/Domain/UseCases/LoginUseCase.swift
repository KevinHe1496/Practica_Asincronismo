//
//  LoginUseCase.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 25/11/24.
//

import Foundation
import KeychainSwift


final class LoginUseCase: LoginUseCaseProtocol {
    
    
    
    var repo: LoginRepositoryProtocol
    
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
        
        if token != "" {
            KeychainSwift().set(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, forKey: token)
            return true
        } else {
            KeychainSwift().delete(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
        
    }
    
    func logout() async {
        KeychainSwift().delete(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if KeychainSwift().get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != "" {
            return true
        } else {
            return false
        }
    }
    
}


final class LoginUseCaseFake: LoginUseCaseProtocol {
    
    var repo: LoginRepositoryProtocol
    
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        KeychainSwift().set(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, forKey: "LoginFakeSuccess")
        
    }
    
    func logout() async {
        KeychainSwift().delete(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        return true
    }
    
}
