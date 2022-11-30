//
//  MainInteractor.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation
import CoreData
import Alamofire

protocol MainInteractorInputProtocol {
    
    func fetchCountrys()
    func resetAllRecords()
    func requestFlagImg(country: Country)
    func requestWeaher(forCity city: City)
    func save(_ citySearch: CitySearch)
    func deleteCity(_ city: City)
}

protocol MainInteractorOutputProtocol: AnyObject {
    func updateCountrysArray(_ array: [Country])
}

class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    
    var countrys = [Country]() {
        didSet {
            print("didSet interator")
            presenter?.updateCountrysArray(countrys)
        }
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
    
    func deleteCity(_ city: City) {
        
        if city.country.citysArray.count == 1 {
            context.delete(city.country)
        } else {
            context.delete(city)
        }
        
        do {
            try context.save()
            self.fetchCountrys()
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
            countrys = [Country]()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // для отладки работы отношений
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
                        
                        DispatchQueue.main.async {
                            self.requestWeaher(forCity: city)
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
                    
                    DispatchQueue.main.async {
                        self.requestWeaher(forCity: city)
                    }
                    print("new city&country save")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateImg(image: Data, in country: Country) {
        country.flagData = image
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateWeather(with weather: WeatherSimple, in city: City) {
        if weather.fact?.temp != nil {
            city.timeAndTemp.temp = weather.fact!.temp!
        }
        if weather.info?.tzinfo?.offset != nil {
            city.timeAndTemp.utcDiff = weather.info!.tzinfo!.offset!
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Request
    func requestFlagImg(country: Country) {
        
        let url = "https://countryflagsapi.com/png/\(country.isoA2)"
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseData { [unowned self] response in
            switch response.result {
            case .success(let data):
                
                self.updateImg(image: data, in: country)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestWeaher(forCity city: City) {
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "80e1e833-ed8f-483b-9870-957eeb4e86a5"
        ]
        let parameters: Parameters = [
            "lat" : city.latitude,
            "lon" : city.longitude,
            "lang" : "en_US",
            "limit" : 1,
            "hours" : "false",
            "extra" : "false"
        ]
        
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?") else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { [unowned self] response in
            switch response.result {
            case .success(let data):
                
                guard let parsedResult: WeatherSimple = try? JSONDecoder().decode(WeatherSimple.self, from: data) else {
                    return
                }
                
                self.updateWeather(with: parsedResult, in: city)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
