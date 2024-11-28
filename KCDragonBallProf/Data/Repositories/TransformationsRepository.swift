//
//  TransformationsRepository.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 28/11/24.
//

import Foundation


final class TransformationsRepository: TransformationsRepositoryProtocol {
    
    private var network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol) {
        self.network = network
    }
    
    
    func getTransformation(id: String) async -> [TransformationModel] {
        return await network.getTransformation(id: id)
    }
    
}


final class TransformationsRepositoryFake: TransformationsRepositoryProtocol {
    
    private var network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol) {
        self.network = network
    }
    
    
    func getTransformation(id: String) async -> [TransformationModel] {
        return await network.getTransformation(id: id)
    }
    
}
