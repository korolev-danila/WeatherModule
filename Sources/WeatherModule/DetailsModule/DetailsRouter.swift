//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import UIKit

protocol DetailsRouterProtocol: AnyObject {

    func popVC()
}

class DetailsRouter: DetailsRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(nc: UINavigationController) {
        self.navigationController = nc
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }    
}
