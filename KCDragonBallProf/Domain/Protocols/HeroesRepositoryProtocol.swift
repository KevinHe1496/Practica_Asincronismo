
import Foundation

protocol HeroesRepositoryProtocol {
    func getHeroes(filter: String) async -> [HeroesModel]
}
