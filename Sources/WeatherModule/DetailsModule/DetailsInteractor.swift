//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import Alamofire

protocol DetailsInteractorProtocol: AnyObject {
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: Weather ) -> ())
    func getIconForDay(icon: String, completion: @escaping (_ svgString: String ) -> ())
}

class DetailsInteractor: DetailsInteractorProtocol {
    weak var presenter: DetailsPresenterProtocol?
    
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: Weather ) -> ()) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast?"
        
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
        
        guard let url = URL(string: url) else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                
                guard let parsedResult: Weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    return
                }
                completion(parsedResult)
  
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func  getIconForDay(icon: String, completion: @escaping (_ svgString: String ) -> ()) {

        
        let url = "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg"
        
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):

                let str = String(decoding: data, as: UTF8.self)
                completion(str)
  
            case .failure(let error):
                print(error)
            }
        }
    }
}
