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
          
          if countrys.filter({ $0.name == citySearch.country }).first != nil {
              do {
//
//                  guard let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: context) else { return }
//                  let trans = Transaction(entity: entity , insertInto: context)
//                  trans.date = Date()
//                  trans.amount = value
//                  trans.addBool = true
//                  coinsCD.filter{ $0.symbol == coin.symbol }.first?.addToHistory(trans)
//
                  try context.save()
                  print("save old city")
              } catch let error as NSError {
                  print(error.localizedDescription)
              }
              
          } else {
              
              guard let entity = NSEntityDescription.entity(forEntityName: "Country", in: context) else { return }
              
              let country = Country(entity: entity , insertInto: context)
              country.name = citySearch.country

              guard let cityEntity = NSEntityDescription.entity(forEntityName: "City", in: context) else { return }
              
              let city = City(entity: cityEntity , insertInto: context)
              city.name = citySearch.name
              print(country)
              print("11$$$$$$$$$$$$$$$$")
              city.country = country
              print("22$$$$$$$$$$$$$$$$")
              print(city.country.name)
              print("33$$$$$$$$$$$$$$$$")
              print(citySearch.isCapital)
              print(city.isCapital)
              city.isCapital = citySearch.isCapital
              city.latitude = citySearch.latitude
              city.longitude = citySearch.longitude
              
              country.addToCitys(city)
              
              do {
                  try context.save()
                  countrys.append(country)
                  view?.tableView.reloadData()
                  print("Let's GOOOOOOOO")
  // Fetch something
                  
              } catch let error as NSError {
                  print(error.localizedDescription)
              }
          }
      }
}
