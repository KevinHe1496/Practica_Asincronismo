//
//  AppState.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 25/11/24.
//

import Foundation


enum LoginState {
    case none
    case success
    case error
}

final class AppState {
    
    @Published var statusLogin: LoginState = .none
    
    func loginApp(user: String, pass: String) {
        
    }
    
    
}
