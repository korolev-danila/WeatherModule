//
//  SearchView.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

import UIKit
import SnapKit

protocol SearchViewProtocol: AnyObject {
    
}

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        
        view.backgroundColor = .blue
        
    }
}

extension SearchViewController: SearchViewProtocol {
    
}
