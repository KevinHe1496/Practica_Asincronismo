//
//  SplashViewModel.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 30/11/24.
//

import Foundation

enum SplashState {
    case loading
    case success
    case error
}

final class SplashViewModel {
    
    var onStateChange = Binding<SplashState>()
    
    func load() {
        onStateChange.update(newValue: .loading)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            DispatchQueue.main.async {
                self?.onStateChange.update(newValue: .success)
            }
            
        }
    }
    
}
