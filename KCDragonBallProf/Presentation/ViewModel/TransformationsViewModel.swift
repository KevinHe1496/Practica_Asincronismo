import Foundation

final class TransformationsViewModel: ObservableObject {
    
    @Published var transformationsData = [TransformationModel]()
    @Published var isLoading = true  // Nuevo estado para saber si está cargando
    
    private var heroesId: HeroesModel
    private var usecaseTransformation: TransformationsUseCaseProtocol
    
    init(heroesId: HeroesModel, transformationsUseCase: TransformationsUseCaseProtocol = TransformationsUseCase()) {
        self.heroesId = heroesId
        self.usecaseTransformation = transformationsUseCase
        Task {
            await getTransformations()
        }
    }
    
    func getTransformations() async {
        let data = await usecaseTransformation.getTransformation(id: heroesId.id.uuidString)
        DispatchQueue.main.async {
            self.transformationsData = data
            self.isLoading = false  // Cambiamos el estado de carga a false
        }
    }
}
