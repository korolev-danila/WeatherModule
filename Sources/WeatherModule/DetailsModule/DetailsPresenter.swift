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
    var weather: Weather? { get set }
    
    func start()
}

class DetailsPresenter {
    
    weak var view: DetailsViewProtocol?
    var router: DetailsRouterProtocol
    var interactor: DetailsInteractorProtocol
    
    var city: City
    var weather: Weather? 
    
    init(interactor: DetailsInteractorProtocol, router: DetailsRouterProtocol, city: City){
        self.interactor = interactor
        self.router = router
        self.city = city
        
        self.interactor.fetchWeaher(forCity: city) { [weak self] weather in
            self?.weather = weather
            self?.view?.configureWeatherView()
            self?.view?.collectionView.reloadData()
            self?.updateIcon()
        }
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    func start() {
        view?.configureCityView()
    }
    
    func updateIcon() {
        if weather?.forecasts != nil {
            var index = 0
            for day in weather!.forecasts! {
                if let icon = day.parts?.dayShort?.icon {
                    DispatchQueue.main.async {
                        self.interactor.getIconForDay(icon: icon) { [weak self] svgString in
                            
                            self?.weather!.forecasts?[index].svgStr = String(svgString.dropFirst(84))
                            index += 1
                            self?.view?.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
