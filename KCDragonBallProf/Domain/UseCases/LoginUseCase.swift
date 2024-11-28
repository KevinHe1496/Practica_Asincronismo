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
    private let keyChain = KeychainSwift()
    
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
        
        if !token.isEmpty {
            keyChain.set(token, forKey: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return true
        } else {
            keyChain.delete(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
        
    }
    
    func logout() async {
        keyChain.delete(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if keyChain.get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != nil {
            return true
        } else {
            return false
        }
    }
    
}


final class LoginUseCaseFake: LoginUseCaseProtocol {
    
    var repo: LoginRepositoryProtocol
    private let keyChain = KeychainSwift()
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        keyChain.set(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, forKey: "LoginFakeSuccess")
        
    }
    
    func logout() async {
        keyChain.delete(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        return true
    }

    
}
