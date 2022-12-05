//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import UIKit
import SnapKit

protocol DetailsViewInputProtocol: AnyObject {
    
    func configureCityView()
    func configureWeatherView()
    func reloadCollection()
    func reloadTableView()
}

protocol DetailsViewOutputProtocol {
    
    func viewDidLoad()
    func popVC()
    func createCityViewModel() -> CityViewModel
    func createFactViewModel() -> FactViewModel
    func forecastCount() -> Int
    func forecastViewModel(heightOfCell: Double,
                           index: IndexPath) -> ForecastViewModel
    func newsCount() -> Int
    func createNewsViewModel(index: IndexPath) -> NewsViewModel
    func printItem(_ index: IndexPath)
}


public class DetailsViewController: UIViewController {
    
    private let presenter: DetailsViewOutputProtocol
    
    private let barButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.contentMode = .center
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let image = UIImage(systemName: "chevron.left",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,
                                                                           weight: .semibold))
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        button.layer.cornerRadius = 22
        button.clipsToBounds = false
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    
    private let imageView: UIImageView = {
        let iView = UIImageView()
        iView.backgroundColor = .yellow
        iView.contentMode = .scaleToFill
        iView.translatesAutoresizingMaskIntoConstraints = false
        
        return iView
    }()
    
    private let bigView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cityView: CitySubView = {
        let view = CitySubView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    
    
    private let newsTableView: UITableView = {
        let tv = UITableView() 
        tv.backgroundColor = .white
        tv.layer.cornerRadius = 15
        tv.layer.borderWidth = 2.0
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.register(NewsCell.self, forCellReuseIdentifier: "tableCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    
    
    // MARK: - initialize & viewDidLoad
    init(presenter: DetailsViewOutputProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        presenter.viewDidLoad()
    }
    
    private func initialize() {
        view.backgroundColor = .white
        
        barButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: barButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        view.addSubview(blurEffectView)
        view.addSubview(imageView)
        view.addSubview(bigView)
        
        bigView.addSubview(cityView)
        bigView.addSubview(collectionView)
        bigView.addSubview(newsTableView)
        
        
        
        blurEffectView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(44)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        
        bigView.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(imageView.snp.bottom).offset(-12)
            make.bottom.equalTo(0)
        }
        
        
        cityView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 6)
        }
        
        cityView.initialize()
        
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(cityView.snp.bottom)
            make.height.equalTo(108)
        }
        
        
        newsTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(2)
        }
    }
    
    // MARK: - Action popVC
    @objc func backButtonTapped() {
        presenter.popVC()
    }
}



// MARK: - DetailsViewInputProtocol
extension DetailsViewController: DetailsViewInputProtocol {
    
    func configureCityView() {
        let model = presenter.createCityViewModel()
        
        if let data = model.countryFlag {
            let img = UIImage(data: data)
            imageView.image = img
        }
        
        cityView.configureCityView(model)
    }
    
    func configureWeatherView() {
        let model = presenter.createFactViewModel()
        
        cityView.configureWeatherView(model)
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func reloadTableView() {
        newsTableView.reloadData()
    }
}



// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter.forecastCount()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        cell.configureCell(presenter.forecastViewModel(heightOfCell: 100, index: indexPath))
        
        return cell
    }
}



// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        presenter.printItem(indexPath)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath) as! NewsCell
        
        cell.configureCell(presenter.createNewsViewModel(index: indexPath))
        
        return cell
    }
}
