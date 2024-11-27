
import Foundation

struct HeroesModel: Codable {
    let id: UUID
    let favorite: Bool
    let description: String
    let photo: String
    let name: String
}


struct HeroModelRequest: Codable {
    let name: String
}
