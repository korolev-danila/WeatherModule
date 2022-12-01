//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation


class DetailsPresenter {
    
    let interactor: DetailsInteractorInputProtocol
    weak var view: DetailsViewInputProtocol?
    var router: DetailsRouterProtocol
    
    
    let city: City
    var weather: Weather? {
        didSet {
            view?.reloadCollection()
        }
    }
    
    init(interactor: DetailsInteractorInputProtocol, router: DetailsRouterProtocol, city: City){
        self.interactor = interactor
        self.router = router
        self.city = city
        
    }
}
    
    // MARK: - DetailsViewOutputProtocol
extension DetailsPresenter: DetailsViewOutputProtocol {
    
    func viewDidLoad() {
     //   interactor.fetchSvgImg()
     //   interactor.requestWeaher(forCity: city)
        view?.configureCityView()
        
    }
    
    func updateIcons() {
        if weather != nil {
            DispatchQueue.main.async {
                self.weather = self.interactor.getIcons(weather: self.weather!)
            }
        }
    }
    
    func popVC() {
        router.popVC()
    }
    
    // MARK: - Update View Method
    func countryFlag() -> Data? {
        return city.country.flagData
    }
    
    func cityName() -> String {
        return city.name
    }
    
    func isCapital() -> Bool {
        return city.isCapital
    }
    
    func populationOfCity() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let string = formatter.string(for: Int(city.population)) else { return "" }
        return string
    }
    
    func forecastCount() -> Int {
        if let count = weather?.forecasts?.count {
            return count
        }
        return 0
    }
    
    func factSeason() -> String {
        if let string = weather?.fact?.season {
            return string
        }
        return ""
    }
    
    func factCondition() -> String {
        if let string = weather?.fact?.condition {
            return string
        }
        return ""
    }
    
    func factWindSpeed() -> String {
        if let double = weather?.fact?.windSpeed {
            return "\(double) m/c"
        }
        return ""
    }
    
    func factWindGust() -> String {
        if let double = weather?.fact?.windGust {
            return "\(double) m/c"
        }
        return ""
    }
    
    func factWindDir() -> String {
        var dir = ""
        switch weather?.fact?.windDir  {
        case "nw": dir = "north-west"
        case "n": dir = "north"
        case "ne": dir = "northeast"
        case "e": dir = "eastern"
        case "se": dir = "south-eastern"
        case "s": dir = "southern"
        case "sw": dir = "southwest"
        case "w": dir = "western"
        case "c": dir = "windless"
        case .none: dir = "windless"
        case .some(_): dir = ""
        }
        return dir
    }
    
    func factPressureMm() -> String {
        if let double = weather?.fact?.pressureMm {
            return "\(Int(double)) mm"
        }
        return ""
    }
    
    func updateCell(heightOfCell: Double, index: IndexPath) -> (dayTemp: String, nightTemp: String,
                                                                    date: String, week: String, svgStr: String?) {
        var dayTemp = ""
        var nightTemp = ""
        var date = ""
        var week = ""
        var svgStr = ""
        
        guard let dayArray = weather?.forecasts else {
            print("weather?.forecasts == nil")
            return (dayTemp, nightTemp, date, week, svgStr)
        }
        guard let day = dayArray[safe: index.row] else { return (dayTemp, nightTemp, date, week, svgStr) }
   
        if let temp = day.parts?.dayShort?.temp {
            dayTemp = "\(Int(temp))"
        }
        
        if let temp = day.parts?.nightShort?.temp {
            nightTemp = "\(Int(temp))"
        }
        
        if day.date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            if let dateSelf = dateFormatter.date(from: day.date!) {
                dateFormatter.dateFormat = "dd.MM"
                date = dateFormatter.string(from: dateSelf)
                dateFormatter.dateFormat = "EEEE"
                week = dateFormatter.string(from: dateSelf)
            }
        }

        if day.svgStr != nil {
            let svgNew = """
<svg xmlns="http://www.w3.org/2000/svg" width="\(heightOfCell*2)" height="\(heightOfCell*2)" viewBox="0 2 28 28">
"""
            svgStr = svgNew + day.svgStr!
        } else {
            updateIcons()
        }
        
        return (dayTemp, nightTemp, date, week, svgStr)
    }
}

// MARK: - DetailsInteractorOutputProtocol
extension DetailsPresenter: DetailsInteractorOutputProtocol {
    
    func updateViewWeather(_ weather: Weather) {
        self.weather = weather
        view?.configureWeatherView()
    }
}


