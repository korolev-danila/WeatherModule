//
//  MainRouter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    func pushSearchView()
}

class MainRouter: MainRouterProtocol {
    weak var view: MainViewController?
    
    func pushSearchView() {
        let vc = SearchModulBuider.build()
        view?.showDetailViewController(vc, sender: nil)
    }
}
