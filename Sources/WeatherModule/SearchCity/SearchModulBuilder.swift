//
//  SearchModulBuilder.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

class SearchModulBuider {
    static func build() -> SearchViewController {
        let interctor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(interactor: interctor, router: router)
        let viewController = SearchViewController(presenter: presenter)
        presenter.view = viewController
        interctor.presenter = presenter
        router.presenter = presenter
        return viewController
    }
}
