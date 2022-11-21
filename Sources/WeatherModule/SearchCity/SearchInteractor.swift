//
//  SearchInteractor.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

import Alamofire

protocol SearchInteractorProtocol: AnyObject {
    
    var presenter: SearchPresenterProtocol? { get set }
    
    func fetchCitysArray(string: String, completion: @escaping (_ citys: [City]) -> ())
}

class SearchInteractor: SearchInteractorProtocol {
    
    
    weak var presenter: SearchPresenterProtocol?
    
    func fetchCitysArray(string: String, completion: @escaping (_ citys: [City])  -> ()) {
        
        var citys = [City]()
        
        let url = "https://api.api-ninjas.com/v1/city?"
        
        let headers: HTTPHeaders = [
            "X-Api-Key": "68RDqAquE3kZPbNHiOWsOA==n1zofIERlsSHI2iB"
        ]
        
        let parameters: Parameters = [
            "name" : string,
            "limit" : 30
        ]
        
        guard let url = URL(string: url) else { return }
        AF.request(url, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] else { return }
                    for dictionary in jsonArray {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
                            var city = try JSONDecoder().decode(City.self, from: jsonData)
                            
                            for iso in Iso3166_1a2.all {
                                if iso.rawValue == city.country {
                                    city.country = iso.country
                                }
                            }
                            citys.append(city)
                            
                        } catch {
                            print(error)
                        }
                    }
                    
                    completion(citys)
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
