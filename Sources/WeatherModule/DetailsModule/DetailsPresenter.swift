//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation

protocol DetailsPresenterProtocol: AnyObject {
    var router: DetailsRouterProtocol { get }
    var city: City { get set }
}

class DetailsPresenter {
    
    weak var view: DetailsViewProtocol?
    var router: DetailsRouterProtocol
    var interactor: DetailsInteractorProtocol
    
    var city: City
    
    init(interactor: DetailsInteractorProtocol, router: DetailsRouterProtocol, city: City){
        self.interactor = interactor
        self.router = router
        self.city = city
        
        self.interactor.fetchWeaher(forCity: city) { weather in
            
        }
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    
}
