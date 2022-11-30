//
//  SearchPresenter.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation


class SearchPresenter: SearchViewOutputProtocol {
    
    weak var view: SearchViewInputProtocol?
    let interactor: SearchInteractorInputProtocol
    unowned private var delegate: MainPresenterDelegate
    
    var citys = [CitySearch]() {
        didSet {
            view?.reloadTableView()
        }
    }
    
    init(interactor: SearchInteractorInputProtocol, delegate: MainPresenterDelegate){
        self.interactor = interactor
        self.delegate = delegate
    }
    
    func citysCount() -> Int {
        return citys.count
    }
    
    func cityName(_ index: IndexPath) -> String {
        return citys[index.row].name
    }
    
    func countreName(_ index: IndexPath) -> String {
        return citys[index.row].country
    }
    
    func save(_ index: IndexPath) {
        delegate.save(citys[index.row])
    }
    
    func requestCities(_ string: String) {
        if !string.trimmingCharacters(in: .whitespaces).isEmpty {
            view?.startAnimation()
            interactor.getCitysArray(forName: string)
        }
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func showCitys(_ citys: [CitySearch]) {
        self.citys = citys
        view?.stopAnimation()
    }
}
