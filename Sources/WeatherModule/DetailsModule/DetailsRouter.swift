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

final class DetailsRouter: DetailsRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(nc: UINavigationController) {
        self.navigationController = nc
    }
    
    deinit {
        print("deinit DetailsRouterProtocol")
    }
    
    public func popVC() {
        self.navigationController?.popViewController(animated: true)
    }    
}
