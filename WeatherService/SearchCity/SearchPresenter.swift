//
//  SearchPresenter.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    
}

class SearchPresenter {
 
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol
    
    init(interactor: SearchInteractorProtocol, router: SearchRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
}
