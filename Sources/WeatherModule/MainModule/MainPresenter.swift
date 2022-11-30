//
//  MainPresenter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation


protocol MainPresenterDelegate: AnyObject  {
    func save(_ citySearch: CitySearch)
}

class MainPresenter: MainViewOutputProtocol {
    
    weak var view: MainViewInputProtocol?
    let router: MainRouterProtocol
    let interactor: MainInteractorInputProtocol
    
    var countrys = [Country]() {
        didSet {
            view?.reloadTableView()
        }
    }
    
    var timer: Timer?
    
    init(interactor: MainInteractorInputProtocol, router: MainRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
    
    
    func start() {
        interactor.fetchCountrys()
        startTimer()
        updateAllTemp()
    }
    
    // MARK: - Router Method
    func didTapButton() {
        router.pushSearchView(delegate: self)
    }
    
    func showDetails(index: IndexPath) {
        router.pushDetailsView(city: countrys[index.section].citysArray[index.row])
    }
    
    // MARK: - Update properties
    func startTimer() {
        if  timer == nil {
            let timer = Timer(timeInterval: 60.0,
                              target: self,
                              selector: #selector(reloadTable),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            
            self.timer = timer
        }
        
        print("updateTime")
    }
    
    @objc func reloadTable() {
        view?.reloadTableView()
    }
    
    func updateAllTemp() {
        DispatchQueue.main.async {
            for country in self.countrys {
                for city in country.citysArray {
                    self.interactor.requestWeaher(forCity: city)
                }
            }
        }
    }
    
    // MARK: - UI Update
    func countrysCount() -> Int {
        return countrys.count
    }
    
    func sectionArrayCount(_ section: Int) -> Int {
        return countrys[section].citysArray.count
    }
    
    func countryName(_ section: Int) -> String {
        return countrys[section].name
    }
    
    func countryFlag(_ section: Int) -> Data? {
        return countrys[section].flagData
    }
    
    func updateName(for index: IndexPath) -> String {
        return countrys[index.section].citysArray[index.row].name
    }
    
    func updateTemp(for index: IndexPath) -> String {
        return "\(Int(countrys[index.section].citysArray[index.row].timeAndTemp.temp))"
    }
    
    func updateTime(for index: IndexPath) -> String {
        
        let time = Date() + countrys[index.section].citysArray[index.row].timeAndTemp.utcDiff
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let timeString = formatter.string(from: time)
        
        return timeString
    }
    
    func updateFlag(forSection section: Int) {
        DispatchQueue.main.async {
            self.interactor.requestFlagImg(country: self.countrys[section])
        }
    }
    
    func deleteCity(for index: IndexPath) {
        interactor.deleteCity(countrys[index.section].citysArray[index.row])
    }
    
    func deleteAll() {
        countrys = [Country]()
        interactor.resetAllRecords()
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func updateCountrysArray(_ array: [Country]) {
        self.countrys = array
    }
}

// MARK: - MainPresenterDelegate
extension MainPresenter: MainPresenterDelegate {
    
    func save(_ citySearch: CitySearch) {
        interactor.save(citySearch)
    }
}
