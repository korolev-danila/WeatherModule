//
//  MainPresenter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation
import CoreData

protocol MainPresenterProtocol: AnyObject {
    
    var citys: [CitySearch] { get set }
    var countrys: [Country] { get set }
    
    func didTapButton()
}

protocol MainPresenterDelegate: AnyObject  {
    
    func save(_ citySearch: CitySearch)
}

class MainPresenter {
 
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    var citys = [CitySearch]()
    var countrys = [Country]()
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol){
        self.interactor = interactor
        self.router = router
        
        fetchCountrys()
        view?.tableView.reloadData()
    }
    
    func didTapButton() {
        router.pushSearchView()
    }
    
    // MARK: - CoreData layer
    func fetchCountrys() {
        
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        
        do {
            countrys = try context.fetch(fetchRequest)
            print(countrys.count)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func resetAllRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
//    func deleteCoin(_ coinCD: CoinCD) {
//
//        context.delete(coinCD)
//
//        do {
//            try context.save()
//            self.fetchMyCoins()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }

}

extension MainPresenter: MainPresenterProtocol {
    
    
}

extension MainPresenter: MainPresenterDelegate {
    
    func save(_ citySearch: CitySearch) {
        
        func createCity(_ citySearch: CitySearch,_ country: Country) -> City? {
            guard let cityEntity = NSEntityDescription.entity(forEntityName: "City", in: context) else { return nil}
            
            let city = City(entity: cityEntity , insertInto: context)
            city.name = citySearch.name
            city.country = country
            city.isCapital = citySearch.isCapital
            city.latitude = citySearch.latitude
            city.longitude = citySearch.longitude
            
            return city
        }
        
        if let country = countrys.filter({ $0.name == citySearch.country }).first {
            do {
                if country.citysArray.filter({ $0.name == citySearch.name }).first == nil {
                    
                    if let city = createCity(citySearch, country) {
                        country.addToCitys(city)
                        try context.save()
                        view?.tableView.reloadData()
                    }
                } else {
                    print("try save old city")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            
            do {
                guard let entity = NSEntityDescription.entity(forEntityName: "Country", in: context) else { return }
                
                let country = Country(entity: entity , insertInto: context)
                country.name = citySearch.country
                
                if let city = createCity(citySearch, country) {
                    country.addToCitys(city)
                    try context.save()
                    countrys.append(country)
                    view?.tableView.reloadData()
    // Fetch something
                    print("new city&country save")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
