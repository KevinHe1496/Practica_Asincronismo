//
//  SplashBuilder.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 30/11/24.
//

import UIKit

final class SplashBuilder {
    func build() -> UIViewController {
        let viewModel = SplashViewModel()
        let ViewController = SplashViewController(viewModel: viewModel)
        return ViewController
    }
}
