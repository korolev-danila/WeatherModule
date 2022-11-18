//
//  SearchInteractor.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject {
    
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
}
