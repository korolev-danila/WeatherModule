//
//  MainRouter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    
}

class MainRouter: MainRouterProtocol {
    weak var presenter: MainPresenterProtocol? 
}
