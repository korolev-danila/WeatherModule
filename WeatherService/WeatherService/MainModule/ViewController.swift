//
//  ViewController.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
}

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension MainViewController: MainViewProtocol {
    
}
