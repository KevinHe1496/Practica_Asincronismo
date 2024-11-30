
import Combine
@testable import KCDragonBallProf

final class TransformationsUseCaseFakeError: TransformationsUseCaseProtocol {
    
    var repo: any KCDragonBallProf.TransformationsRepositoryProtocol
    
    init(repo: any KCDragonBallProf.TransformationsRepositoryProtocol) {
        self.repo = repo
    }
    
    func getTransformation(id: String) async -> [KCDragonBallProf.TransformationModel] {
        
        return []
        
    }
    
}

