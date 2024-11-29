//
//  TransformationsUseCase.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 28/11/24.
//

import Foundation


protocol TransformationsUseCaseProtocol {
    
    var repo: TransformationsRepositoryProtocol { get set }
    
    func getTransformation(id: String) async -> [TransformationModel]
    
}

final class TransformationsUseCase: TransformationsUseCaseProtocol {
    
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformations())) {
        self.repo = repo
    }
    
    func getTransformation(id: String) async -> [TransformationModel] {
        return await repo.getTransformation(id: id)
    }
    
    
}



final class TransformationsUseCaseFake: TransformationsUseCaseProtocol {
    
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformationsFake())) {
        self.repo = repo
    }
    
    func getTransformation(id: String) async -> [TransformationModel] {
        return await repo.getTransformation(id: id)
    }
    
    
}
