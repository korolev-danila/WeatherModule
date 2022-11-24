//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation

protocol DetailsInteractorProtocol: AnyObject {
    
}

class DetailsInteractor: DetailsInteractorProtocol {
    weak var presenter: DetailsPresenterProtocol?
   
}
