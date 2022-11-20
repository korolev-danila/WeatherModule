//
//  SearchRouter.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

protocol SearchRouterProtocol: AnyObject {
    
}

class SearchRouter: SearchRouterProtocol {
    weak var presenter: SearchPresenterProtocol?
}
