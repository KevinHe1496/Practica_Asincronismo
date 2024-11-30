
import Combine
@testable import KCDragonBallProf

final class HeroesUseCaseFakeError: HeroesUseCaseProtocol {
    
    var repo: KCDragonBallProf.HeroesRepositoryProtocol
    
    init(repo: KCDragonBallProf.HeroesRepositoryProtocol) {
        self.repo = repo
    }
    
    func getHeroes(filter: String) async -> [KCDragonBallProf.HeroesModel] {
        // Simula un error devolviendo una lista vacía
        return []
    }
}
