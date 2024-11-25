//
//  LoginUseCase.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 25/11/24.
//

import Foundation


final class LoginUseCase: LoginUseCaseProtocol {
    
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
    }
}
