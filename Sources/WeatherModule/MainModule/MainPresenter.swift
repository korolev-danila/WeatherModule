//
//  MainPresenter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation
import CoreData

protocol MainPresenterProtocol: AnyObject {
    
    var countrys: [Country] { get set }
    
    func didTapButton()
    func showDetails(index: IndexPath)
    func deleteCity(for index: IndexPath)
    func updateTime(city: City) -> String
    func updateFlag(country: Country)
}

protocol MainPresenterDelegate: AnyObject  {
    
    func save(_ citySearch: CitySearch)
}

class MainPresenter {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    var countrys = [Country]()
    
    var timer: Timer?
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol){
        self.interactor = interactor
        self.router = router
        
        //     resetAllRecords()
        //   searchCountCityAndTempEntity()
        
        fetchCountrys()
        startTimer()
        updateAllTemp()
    }
    
    
    // MARK: - Router Method
    func didTapButton() {
        router.pushSearchView()
    }
    
    func showDetails(index: IndexPath) {
        router.pushDetailsView(city: countrys[index.section].citysArray[index.row])
    }
    
    // MARK: - CoreData layer
    func fetchCountrys() {
        
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        
        do {
            countrys = try context.fetch(fetchRequest)
            print("countrys.count = \(countrys.count)")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteCity(for index: IndexPath) {
        
        if countrys[index.section].citysArray.count == 1 {
            context.delete(countrys[index.section])
        } else {
            let city = countrys[index.section].citysArray[index.row]
            context.delete(city)
        }
        
        do {
            try context.save()
            self.fetchCountrys()
            self.view?.tableView.reloadData()
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
    
    func searchCountCityAndTempEntity() {

        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        let fetchRequest2: NSFetchRequest<TimeAndTemp> = TimeAndTemp.fetchRequest()
        
        do {
            let citys = try context.fetch(fetchRequest)
            let timeAndTemp = try context.fetch(fetchRequest2)
            
            print("citys.count = \(citys.count)")
            print("timeAndTemp.count = \(timeAndTemp.count)")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Update properties
    func startTimer() {
        if  timer == nil {
            let timer = Timer(timeInterval: 60.0,
                              target: self,
                              selector: #selector(reloadTable),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            
            self.timer = timer
        }
        
        print("updateTime")
    }
    
    @objc func reloadTable() {
        view?.tableView.reloadData()
    }
    
    func updateTime(city: City) -> String {
        
        let time = Date() + city.timeAndTemp.utcDiff 
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let timeString = formatter.string(from: time)
        
        return timeString
    }
    
    func updateAllTemp() {
        DispatchQueue.main.async {
            for country in self.countrys {
                for city in country.citysArray {
                    self.updateTemp(to: city)
                }
            }
        }
    }
    
    func updateFlag(country: Country) {
        
        DispatchQueue.main.async {
            self.interactor.fetchFlagImg(isoA2: country.isoA2) { [weak self] flagData in
                
                country.flagData = flagData
                
                do {
                    try context.save()
                    self?.view?.tableView.reloadData()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func updateTemp(to city: City) {
        
        self.interactor.fetchWeaher(forCity: city) { [weak self] weather in
            
            if weather.fact?.temp != nil {
                city.timeAndTemp.temp = weather.fact!.temp!
            }
            if weather.info?.tzinfo?.offset != nil {
                city.timeAndTemp.utcDiff = weather.info!.tzinfo!.offset!
            }
            
            do {
                try context.save()
                self?.view?.tableView.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    
}

// MARK: - MainPresenterDelegate
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
            if citySearch.population != nil {
                city.population = Double(citySearch.population!)
            } else {
                city.population = 0.0
            }
            if let timeAndTemp = createTimeAndTemp(for: city) {
                city.timeAndTemp = timeAndTemp
            }
            
            return city
        }
        
        func createTimeAndTemp(for city: City) -> TimeAndTemp? {
            guard let timeAndTempEntity = NSEntityDescription.entity(forEntityName: "TimeAndTemp", in: context) else { return nil }
            
            let timeAndTemp = TimeAndTemp(entity: timeAndTempEntity, insertInto: context)
            timeAndTemp.city = city
            timeAndTemp.temp = 0.0
            timeAndTemp.utcDiff = 0.0
            
            return timeAndTemp
        }
        
        // Create only city
        if let country = countrys.filter({ $0.name == citySearch.country }).first {
            
            do {
                if country.citysArray.filter({ $0.name == citySearch.name }).first == nil {
                    
                    if let city = createCity(citySearch, country) {
                        country.addToCitys(city)
                        try context.save()
                        view?.tableView.reloadData()
                        
                        DispatchQueue.main.async {
                            self.updateTemp(to: city)
                        }
                    }
                } else {
                    print("try save old city")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            // Create country and city
            do {
                guard let entity = NSEntityDescription.entity(forEntityName: "Country", in: context) else { return }
                
                let country = Country(entity: entity , insertInto: context)
                country.name = citySearch.country
                
                if citySearch.isoA2 != nil {
                    country.isoA2 = citySearch.isoA2!
                } else {
                    print("citySearch.isoA2 == nil")
                }
                
                
                if let city = createCity(citySearch, country) {
                    country.addToCitys(city)
                    try context.save()
                    countrys.append(country)
                    view?.tableView.reloadData()
                    
                    DispatchQueue.main.async {
                        self.updateTemp(to: city)
                    }
                    print("new city&country save")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
