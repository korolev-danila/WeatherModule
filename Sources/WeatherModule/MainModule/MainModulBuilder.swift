//
//  MainModulBuilder.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//
import UIKit

public class MainModulBuider {
    public static func build() -> UINavigationController {
        let interctor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interctor, router: router)
        let viewController = MainViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        interctor.presenter = presenter
        router.navigationController = navigationController
        router.delegate = presenter
        
        return navigationController
    }
}
