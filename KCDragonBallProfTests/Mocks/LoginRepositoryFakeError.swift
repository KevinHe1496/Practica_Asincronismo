//
//  LoginRepositoryFakeError.swift
//  KCDragonBallProfTests
//
//  Created by Kevin Heredia on 30/11/24.
//

import Foundation
@testable import KCDragonBallProf

final class LoginRepositoryFakeError: LoginRepositoryProtocol {
    
    // Método para simular un login fallido
    func loginApp(user: String, password: String) async -> String {
        if user.isEmpty || password.isEmpty {
            return "Error: Datos incorrectos" // Mensaje de error si los datos no son válidos
        }
        return "Login exitoso" // Mensaje de éxito si las credenciales son correctas (aunque no se use en este test)
    }
    
}
