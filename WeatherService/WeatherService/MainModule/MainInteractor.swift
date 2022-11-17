//
//  MainInteractor.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
}
