//
//  TransformationsRepositoryProtocol.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 28/11/24.
//

import Foundation

protocol TransformationsRepositoryProtocol {
    
    func getTransformation(id: String) async -> [TransformationModel]
    
}
