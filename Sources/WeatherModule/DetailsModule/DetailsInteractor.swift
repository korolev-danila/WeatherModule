//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import Alamofire
import CoreData

protocol DetailsInteractorInputProtocol {
    func requestWeaher(forCity city: City)
    func getIcons(weather: Weather) -> Weather
    func fetchSvgImg()
}

protocol DetailsInteractorOutputProtocol: AnyObject {
    func updateViewWeather(_ weather: Weather)
}

class DetailsInteractor: DetailsInteractorInputProtocol {
    
    weak var presenter: DetailsInteractorOutputProtocol?
    
    var svgImgs: [SvgImg] = []
    
    // MARK: - CoreData layer
    func fetchSvgImg() {
        
        let fetchRequest: NSFetchRequest<SvgImg> = SvgImg.fetchRequest()
        
        do {
            svgImgs = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func save(icon: String, svg: String) {
        if svgImgs.filter({ $0.iconName == icon }).first == nil {
            
            guard let svgEntity = NSEntityDescription.entity(forEntityName: "SvgImg", in: context) else { return }
            
            let svgImg = SvgImg(entity: svgEntity, insertInto: context)
            svgImg.iconName = icon
            svgImg.svg = svg
           
            do {
                try context.save()
                svgImgs.append(svgImg)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func  getIcons(weather: Weather) -> Weather {
        
        var weatherLocal = weather
        if weatherLocal.forecasts != nil {
            var index = 0
            
            for _ in weatherLocal.forecasts! {
                
                if let icon = weatherLocal.forecasts![index].parts?.dayShort?.icon {
        
                    if let model = svgImgs.filter({ $0.iconName == icon }).first {
                        weatherLocal.forecasts![index].svgStr = model.svg
                    } else {
                        DispatchQueue.main.async {
                            self.fetchIcon(icon)
                        }
                    }
                }
                index += 1
            }
        }
        
        return weatherLocal
    }

    
    // MARK: - Api request layer
    func requestWeaher(forCity city: City) {
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "80e1e833-ed8f-483b-9870-957eeb4e86a5"
        ]
        let parameters: Parameters = [
            "lat" : city.latitude,
            "lon" : city.longitude,
            "lang" : "en_US",
            "limit" : 7,
            "hours" : "false",
            "extra" : "false"
        ]
        
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?") else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                
                guard let parsedResult: Weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    return
                }
                let weatherUp = self.getIcons(weather: parsedResult)
                self.presenter?.updateViewWeather(weatherUp)
  
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func getPhotoOfCity(name: String, completion: @escaping (_ image: Data ) -> ()) {
//
//
//        // https://api.teleport.org/api/urban_areas/slug:amsterdam/images/
//
//        // https://api.teleport.org/api/locations/37.77493,-122.41942/
//
//        // https://maps.googleapis.com/maps/api/place/findplacefromtext
//
//        // https://airlabs.co/docs/cities slug and
//        // https://developers.amadeus.com/self-service/category/air/api-doc/airport-and-city-search/api-reference
//
//    }
    
    func fetchIcon(_ icon: String) {
        
        let url = "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg"
        
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
  
                let str = String(decoding: data, as: UTF8.self)
                let svg = String(str.dropFirst(84)) /// в presentere возвращается строка с нужными размерами
                
                weak var _self = self
                
                _self?.save(icon: icon, svg: svg)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
