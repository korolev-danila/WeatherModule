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
    weak var delegate: MainPresenterDelegate?
    
    func pushSearchView() {
        if delegate != nil {
            let vc = SearchModulBuider.build(delegate: delegate!)
            view?.showDetailViewController(vc, sender: nil)
        } else {
            print("MainPresenterDelegate == nil")
        }
    }
}
