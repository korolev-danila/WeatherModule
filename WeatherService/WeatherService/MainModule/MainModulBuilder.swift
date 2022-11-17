//
//  MainModulBuilder.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import UIKit

class MainModulBuider {
    static func build() -> MainViewController {
        let interctor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interctor, router: router)
        let viewController = MainViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interctor.presenter = presenter
        router.presenter = presenter
        return viewController
    }
}
