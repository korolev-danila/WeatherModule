//
//  MainPresenter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation

struct HeaderCellViewModel {
    let name: String
    let imgData: Data
}

struct MainCellViewModel {
    let name: String
    let temp: String
    let time: String
}

protocol MainPresenterDelegate: AnyObject  {
    func save(_ citySearch: CitySearch)
}

class MainPresenter {
    
    weak var view: MainViewInputProtocol?
    let router: MainRouterProtocol
    let interactor: MainInteractorInputProtocol
    
    var countrys: [Country] = [] {
        didSet {
            view?.reloadTableView()
        }
    }
    
    var timer: Timer?
    
    init(interactor: MainInteractorInputProtocol, router: MainRouterProtocol){
        self.interactor = interactor
        self.router = router
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
}



// MARK: - MainViewOutputProtocol
extension MainPresenter: MainViewOutputProtocol {
    
    func viewDidLoad() {
        interactor.fetchCountrys()
        startTimer()
        updateAllTemp()
    }
    

    
    // MARK: - didTap Method
    func didTapButton() {
        router.pushSearchView(delegate: self)
    }
    
    func showDetails(index: IndexPath) {
        router.pushDetailsView(city: countrys[index.section].citysArray[index.row])
    }
    
    func deleteCity(for index: IndexPath) {
        interactor.deleteCity(countrys[index.section].citysArray[index.row])
    }
    
    func deleteAll() {
        countrys = []
        interactor.resetAllRecords()
    }


    
    // MARK: - UI Update
    func countrysCount() -> Int {
        return countrys.count
    }
    
    func sectionArrayCount(_ section: Int) -> Int {
        return countrys[section].citysArray.count
    }
    
    func createHeaderViewModel(_ section: Int) -> HeaderCellViewModel {
        
        var data = Data()
        
        if let flagData = countrys[safe: section]?.flagData {
            if flagData == data {
                updateFlag(forSection: section)
            } else {
                data = flagData
            }
        } else {
            updateFlag(forSection: section)
        }
        
        return HeaderCellViewModel(name: countrys[safe: section]?.name ?? "",
                                   imgData: data)
    }
    
    func createCellViewModel(for index: IndexPath) -> MainCellViewModel {

        let name = countrys[safe: index.section]?.citysArray[safe: index.row]?.name ?? ""
        let temp = "\(Int(countrys[safe: index.section]?.citysArray[safe: index.row]?.timeAndTemp.temp ?? 0))"
        
        let time = Date() + (countrys[safe: index.section]?.citysArray[safe: index.row]?.timeAndTemp.utcDiff ?? 0.0)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let timeString = formatter.string(from: time)
        
        return  MainCellViewModel(name: name, temp: temp, time: timeString)
    }
    
    func updateFlag(forSection section: Int) {
        if let country = countrys[safe: section] {
            DispatchQueue.main.async {
                self.interactor.requestFlagImg(country: country)
            }
        }
    }
}

// MARK: - MainInteractorOutputProtocol
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

// MARK: - Collection safe index
extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
