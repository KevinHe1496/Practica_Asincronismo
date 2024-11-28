//
//  NetworkTransformations.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 28/11/24.
//

import Foundation
import KeychainSwift
import Combine
import CombineCocoa

protocol NetworkTransformationsProtocol {
    
    func getTransformation(id: String) async -> [TransformationModel]
    
}

final class NetworkTransformations: NetworkTransformationsProtocol {
    
    private let keyChain = KeychainSwift()

    func getTransformation(id: String) async -> [TransformationModel] {
        
        var modelReturn = [TransformationModel]()
        
        let urlCad: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.transformations.rawValue)"
        
        guard let url = URL(string: urlCad) else {
            print("Url incorrecto")
            return []
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HeroModel(id: id))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-Type")
        
        // Token
        let jwtToken = keyChain.get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        guard let tokenJWT = jwtToken else {
            print("Token no Obtenido")
            return []
        }
        request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case HTTPReponseCodes.SUCCESS:
                    modelReturn = try JSONDecoder().decode([TransformationModel].self, from: data)
                default:
                    print("Error: Codigo de estado \(httpResponse.statusCode)")
                }
            }
            
        } catch {
            print("Error al cargar transformacions \(error.localizedDescription)")
        }
        return modelReturn
        
    }
    
}



final class NetworkTransformationsFake: NetworkTransformationsProtocol {
    
    private let keyChain = KeychainSwift()

    func getTransformation(id: String) async -> [TransformationModel] {
        
        return  getTransformationFromJson()
    }
    
}

func getTransformationFromJson() -> [TransformationModel] {
    if let url = Bundle.main.url(forResource: "transformation", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([TransformationModel].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return []
}

