//
//  LoginRepositoryFake.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 25/11/24.
//

import Foundation

final class LoginRepositoryFake: LoginRepositoryProtocol {
    private var network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol) {
        self.network = network
    }
    
    func loginApp(user: String, password: String) async -> String {
        return await network.loginApp(user: user, password: password)
    }
    
    
}
