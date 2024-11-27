
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
  
 
    func getHeroes(filter: String) async  -> [HeroesModel] {
        let model1 = HeroesModel(id: UUID(),
                                favorite: true,
                                description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
                                photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
                                name: "Goku")

       let model2 = HeroesModel(id: UUID(),
                               favorite: true,
                               description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.",
                               photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
                               name: "Vegeta")

       return [model1, model2]
    }
    
    
    
}
