//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation

struct CityViewModel {
    let cityName: String
    let countryFlag: Data?
    let isCapital: Bool
    let populationOfCity: String
}

struct FactViewModel {
    let season: String
    let condition: String
    let windSpeed: String
    let windGust: String
    let windDir: String
    let pressureMm: String
}

struct ForecastViewModel {
    let dayTemp: String
    let nightTemp: String
    let date: String
    let week: String
    let svgStr: String
}

struct NewsViewModel {
    let title: String
    let description: String
    let date: String
}


class DetailsPresenter {
    
    private let interactor: DetailsInteractorInputProtocol
    private let router: DetailsRouterProtocol
    weak var view: DetailsViewInputProtocol?
    
    
    private let city: City
    private var weather: Weather? {
        didSet {
            view?.reloadCollection()
        }
    }
    
    private var news: News? {
        didSet {
            view?.reloadTableView()
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
        
        interactor.requestWeaher(forCity: city)
        view?.configureCityView()
        DispatchQueue.main.async {
            self.interactor.getNewsForCity(self.city.name)
        }
    }
    
    func popVC() {
        router.popVC()
    }
    
    func createCityViewModel() -> CityViewModel {
        var population = ""
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let string = formatter.string(for: Int(city.population)){
            population = string
        }
        
        return CityViewModel(cityName: city.name,
                             countryFlag: city.country.flagData,
                             isCapital: city.isCapital,
                             populationOfCity: population)
    }
    
    func createFactViewModel() -> FactViewModel {
        
        var windSpeed = ""
        var gust = ""
        var pressur = ""
        var dir = ""
        
        if let speed = weather?.fact?.windSpeed {
            windSpeed = "\(speed) m/c"
        }
        if let double = weather?.fact?.windGust {
            gust = "\(double) m/c"
        }
        if let double = weather?.fact?.pressureMm {
            pressur = "\(Int(double)) mm"
        }
        
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

        return FactViewModel(season: weather?.fact?.season ?? "",
                             condition: weather?.fact?.condition ?? "",
                             windSpeed: windSpeed,windGust: gust,
                             windDir: dir, pressureMm: pressur)
    }
    
    func forecastCount() -> Int {
        if let count = weather?.forecasts?.count {
            return count
        }
        return 0
    }
    
    func forecastViewModel(heightOfCell: Double, index: IndexPath) -> ForecastViewModel {
        var dayTemp = ""
        var nightTemp = ""
        var date = ""
        var week = ""
        var svgStr = ""

        if let  day = weather?.forecasts?[safe: index.row] {
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
            if let svg = day.svgStr {
                let svgOld = String(svg.dropFirst(84))
                let svgNew = """
    <svg xmlns="http://www.w3.org/2000/svg" width="\(heightOfCell*2)" height="\(heightOfCell*2)" viewBox="0 2 28 28">
    """
                svgStr = svgNew + svgOld
            }
        }
 
        return ForecastViewModel(dayTemp: dayTemp, nightTemp: nightTemp,
                                 date: date, week: week, svgStr: svgStr)
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
        }
        
        return (dayTemp, nightTemp, date, week, svgStr)
    }
    
    func newsCount() -> Int {
        if let count = news?.articles?.count {
            return count
        }
        return 0
    }
    
    func createNewsViewModel(index: IndexPath) -> NewsViewModel {
        
        var title = ""
        var description = ""
        var date = ""
        
        if let item = news?.articles?[safe: index.row] {
            if item.title != nil && item.articleDescription != nil {
                title = item.title!
                description = item.articleDescription!
            }
            
            if item.publishedAt != nil {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let datePublished = dateFormatter.date(from: item.publishedAt!)
                dateFormatter.dateFormat = "dd.MM"
                if datePublished != nil {
                    date = dateFormatter.string(from: datePublished!)
                }
            }
        }
        
        return NewsViewModel(title: title, description: description, date: date)
    }
    
    func printItem(_ index: IndexPath) {
        print(news?.articles?[index.row])
    }
}

// MARK: - DetailsInteractorOutputProtocol
extension DetailsPresenter: DetailsInteractorOutputProtocol {
    
    func updateViewWeather(_ weather: Weather) {
        self.weather = weather
        view?.configureWeatherView()
    }
    
    func updateNews(_ news: News) {
        self.news = news
    }
}


