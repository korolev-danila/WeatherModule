//
//  SearchPresenter.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    
    var citys: [CitySearch] { get set }
    
    func save(_ index: IndexPath)
    func fetchCitys(_ string: String)
}

class SearchPresenter {
    
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol
    
    weak var delegate: MainPresenterDelegate?
    
    var citys = [CitySearch]()
    
    init(interactor: SearchInteractorProtocol, delegate: MainPresenterDelegate){
        self.interactor = interactor
        self.delegate = delegate
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func save(_ index: IndexPath) {
        delegate?.save(citys[index.row])
    }
    
    func fetchCitys(_ string: String) {
        view?.showActivityIndicator()
        interactor.fetchCitysArray(string: string) { [weak self] data in
            self?.citys = data
            self?.view?.hideActivityIndicator()
            self?.view?.tableView.reloadData()
        }
    }
}
