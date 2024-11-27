

import Foundation

protocol HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol { get set }
    func getHeroes(filter: String) async -> [HeroesModel]
}

final class HeroesUseCase: HeroesUseCaseProtocol {
    
    var repo: HeroesRepositoryProtocol
    
    init(repo: HeroesRepositoryProtocol = HeroesRepository(network: NetworkHeroes())) {
        self.repo = repo
    }
    
    func getHeroes(filter: String) async -> [HeroesModel] {
        return await repo.getHeroes(filter: filter)
    }
    
    
}


final class HeroesUseCaseFake: HeroesUseCaseProtocol {
    
    var repo: HeroesRepositoryProtocol
    
    init(repo: HeroesRepositoryProtocol = HeroesRepository(network: NetworkHeroesFake())) {
        self.repo = repo
    }
    
    func getHeroes(filter: String) async -> [HeroesModel] {
        return await repo.getHeroes(filter: filter)
    }
    
    
}
