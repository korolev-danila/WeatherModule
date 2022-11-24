//
//  MainInteractor.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation
import Alamofire

protocol MainInteractorProtocol: AnyObject {
    
    func fetchFlagImg(isoA2: String, completion: @escaping (_ flagImg: Data ) -> ())
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: WeatherSimple ) -> ())
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
    
    func fetchFlagImg(isoA2: String, completion: @escaping (_ flagData: Data ) -> ()) {
        
        let url = "https://countryflagsapi.com/png/\(isoA2)"
        
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                
                print("$$$$")
                completion(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: WeatherSimple ) -> ()) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast?"
        
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
        
        guard let url = URL(string: url) else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                
                    guard let parsedResult: WeatherSimple = try? JSONDecoder().decode(WeatherSimple.self, from: data) else {
                        return
                    }
                    completion(parsedResult)
               
            case .failure(let error):
                print(error)
            }
        }
    }
}

