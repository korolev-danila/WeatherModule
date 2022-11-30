//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation


class DetailsPresenter: DetailsViewOutputProtocol {
    
    weak var view: DetailsViewInputProtocol?
    var router: DetailsRouterProtocol
    var interactor: DetailsInteractorInputProtocol
    
    var city: City
    var weather: Weather? 
    
    init(interactor: DetailsInteractorInputProtocol, router: DetailsRouterProtocol, city: City){
        self.interactor = interactor
        self.router = router
        self.city = city
        
//        self.interactor.fetchWeaher(forCity: city) { [weak self] weather in
//            self?.weather = weather
//            self?.view?.configureWeatherView()
//            self?.view?.collectionView.reloadData()
//            self?.updateIcon()
//        }
    }
}

extension DetailsPresenter: DetailsInteractorOutputProtocol {
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
