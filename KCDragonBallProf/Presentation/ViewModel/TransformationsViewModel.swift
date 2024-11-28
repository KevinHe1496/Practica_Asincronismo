
import Foundation

final class TransformationsViewModel: ObservableObject {
    
    @Published var transformationsData = [TransformationModel]()
    
    private var heroesId: HeroesModel
    private var transformationsUseCase: TransformationsUseCaseProtocol
    
    init(heroesId: HeroesModel, transformationsUseCase: TransformationsUseCaseProtocol = TransformationsUseCase()) {
        self.heroesId = heroesId
        self.transformationsUseCase = transformationsUseCase
        Task {
            await getTransformations()
        }
    }
    
    func viewDidLoad() {
        
    }
    
    
    func getTransformations() async {
        let data = await transformationsUseCase.getTransformation(id: heroesId.id.uuidString)
        DispatchQueue.main.async {
            self.transformationsData = data
        }
    }
    
}
