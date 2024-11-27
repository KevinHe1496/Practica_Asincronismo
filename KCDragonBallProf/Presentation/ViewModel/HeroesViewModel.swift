//
//  HeroesViewModel.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 26/11/24.
//

import Foundation


final class HeroesViewModel: ObservableObject {
    @Published var herosData = [HeroesModel]()
    
    private var usecaseHeroes: HeroesUseCaseProtocol
    
    init(usecaseHeroes: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.usecaseHeroes = usecaseHeroes
        Task {
            await getHeroes()
        }
    }
    
    
    func viewDidLoad() {
        
    }
    
    func getHeroes() async {
        let data = await usecaseHeroes.getHeroes(filter: "")
        DispatchQueue.main.async {
            self.herosData = data
        }
    }
    
   
    
}
