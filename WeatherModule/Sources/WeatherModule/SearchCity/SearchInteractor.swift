//
//  SearchInteractor.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

// https://api-ninjas.com/api/city

protocol SearchInteractorProtocol: AnyObject {
    
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
}
