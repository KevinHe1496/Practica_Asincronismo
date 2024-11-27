
import Foundation
import KeychainSwift
import Combine
import CombineCocoa

protocol NetworkHeroesProtocol {
    func getHeroes(filter: String) async  -> [HeroesModel]
}

final class NetworkHeroes: NetworkHeroesProtocol {
    func getHeroes(filter: String) async  -> [HeroesModel] {
        var modelReturn = [HeroesModel]()
        
        let urlCad: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.heroes.rawValue)"
        guard let url = URL(string: urlCad) else {
            print("Url incorrecto")
            return []
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        
        /*
         resultado del jsonEncoder para mandar al servidor:
         {
           "name": "valor de filter"
         }

         */
        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-Type")
        
        // Token
        let JwtToken = KeychainSwift().get(ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        if let tokenJWT = JwtToken {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPReponseCodes.SUCCESS {
                    modelReturn = try! JSONDecoder().decode([HeroesModel].self, from: data)
                }
            }
        } catch {
            
        }
        return modelReturn
    }
    
    
    
}


final class NetworkHeroesFake: NetworkHeroesProtocol {
    
    func getHeroes(filter: String) async -> [HeroesModel] {
        return getHeroesFromJson()
    }
}
    
    func getHeroesFromJson() -> [HeroesModel] {
        if let url = Bundle.main.url(forResource: "heroes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([HeroesModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
    

