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
}

