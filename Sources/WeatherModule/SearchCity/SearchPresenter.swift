//
//  SearchPresenter.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    
    var citys: [City] { get set }
    
    func fetchCitys(_ string: String)
}

class SearchPresenter {
    
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol
    
    var citys = [City]()
    
    init(interactor: SearchInteractorProtocol, router: SearchRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func fetchCitys(_ string: String) {
        view?.showActivityIndicator()
        interactor.fetchCitysArray(string: string) { [weak self] data in
            self?.citys = data
            self?.view?.hideActivityIndicator()
            self?.view?.tableView.reloadData()
        }
    }
}
