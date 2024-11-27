
import Foundation

final class HeroesRepository: HeroesRepositoryProtocol {
    
    private var network: NetworkHeroesProtocol
    
    init(network: NetworkHeroesProtocol) {
        self.network = network
    }
    
    func getHeroes(filter: String) async -> [HeroesModel] {
        return await network.getHeroes(filter: filter)
    }
    
    
}


final class HeroesRepositoryFake: HeroesRepositoryProtocol {
    
    private var network: NetworkHeroesProtocol
    
    init(network: NetworkHeroesProtocol = NetworkHeroesFake()) {
        self.network = network
    }
    
    func getHeroes(filter: String) async -> [HeroesModel] {
        return await network.getHeroes(filter: filter)
    }
    
    
}
