//
//  MainPresenter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func didTapButton()
}

class MainPresenter {
 
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
    
    func didTapButton() {
        router.pushSearchView()
    }
}

extension MainPresenter: MainPresenterProtocol {
    
}
