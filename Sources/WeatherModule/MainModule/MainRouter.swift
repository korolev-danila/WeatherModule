//
//  MainRouter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    func pushSearchView()
    func pushDetailsView(city: City)
}

class MainRouter: MainRouterProtocol {
    weak var navigationController: UINavigationController?
    weak var delegate: MainPresenterDelegate?
    
    func pushSearchView() {
        if delegate != nil {
            let vc = SearchModulBuider.build(delegate: delegate!)
            navigationController?.showDetailViewController(vc, sender: nil)
        } else {
            print("MainPresenterDelegate == nil")
        }
    }
    
    func pushDetailsView(city: City) {
        if navigationController != nil {
            let vc = DetailsModulBuider.build(nc: navigationController!, city: city)
            print("push Details")
            navigationController!.pushViewController(vc, animated: true)
        }
    }
}
