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
            
    func reloadCollection()
    func configureCityView()
    func configureWeatherView()
}

protocol DetailsViewOutputProtocol {
    
    func viewDidLoad()
    func popVC()
    func createCityViewModel() -> CityViewModel
    func createFactViewModel() -> FactViewModel
    func forecastCount() -> Int
    func forecastViewModel(heightOfCell: Double,
                    index: IndexPath) -> ForecastViewModel
}


public class DetailsViewController: UIViewController {
    
    private let presenter: DetailsViewOutputProtocol
    
    private let barButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
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
    
    
    
    // MARK: - cityView
    private let cityView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let nameCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "Name of City"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let isCapitalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 11
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        
        return imageView
    }()
    
    private let populationTextCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.textAlignment  = .right
        label.text = "Population:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let populationCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.textAlignment  = .left
        label.text = "999999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    

    // MARK: - seasonView
    private let seasonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let seasonTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment  = .right
        label.text = "Season:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment  = .left
        label.text = "summer"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let conditionTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment  = .right
        label.text = "Condition:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "thunderstorm-with-rain"
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    // MARK: - windView
    private let windView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let windSpeedTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Wind speed:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "120 m/c"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windGustTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Wind gust:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windGustLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "120 m/c"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windDirTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Direction:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windDirLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "southwest"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let pressureMmTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Pressure:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let pressureMmLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "100 mm"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    // MARK: - factView
    private let factView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    func initialize() {
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(imageView)
        view.addSubview(bigView)
        
        bigView.addSubview(cityView)
        bigView.addSubview(collectionView)
        bigView.addSubview(factView)
        
        cityView.addSubview(nameCityLabel)
        cityView.addSubview(isCapitalImageView)

        cityView.addSubview(seasonView)
        cityView.addSubview(windView)
        
        seasonView.addSubview(populationTextCityLabel)
        seasonView.addSubview(populationCityLabel)
        seasonView.addSubview(seasonTextLabel)
        seasonView.addSubview(seasonLabel)
        seasonView.addSubview(conditionTextLabel)
        seasonView.addSubview(conditionLabel)
        
        windView.addSubview(windSpeedTextLabel)
        windView.addSubview(windSpeedLabel)
        windView.addSubview(windGustTextLabel)
        windView.addSubview(windGustLabel)
        windView.addSubview(windDirTextLabel)
        windView.addSubview(windDirLabel)
        windView.addSubview(pressureMmTextLabel)
        windView.addSubview(pressureMmLabel)
        
        barButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: barButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(blurEffectView)
 
        blurEffectView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(34)
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
        
        
    
        // MARK: - cityView.snp.makeConstraints
        cityView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 6)
        }
        
        isCapitalImageView.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.top.equalTo(6)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        nameCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(isCapitalImageView.snp.trailing).offset(6)
            make.top.equalTo(6)
            make.height.equalTo(26)
            make.trailing.equalTo(-8)
        }
        
        
        
        
        // MARK: - seasonView.snp.makeConstraints
        seasonView.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cityView.snp.centerX).offset(-10)
            make.bottom.equalToSuperview()
        }
        populationTextCityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(seasonView.snp.centerX).offset(-10)
            make.height.equalTo(20)
        }
        populationCityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(populationTextCityLabel.snp.centerY)
            make.leading.equalTo(seasonView.snp.centerX).offset(-2)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        seasonTextLabel.snp.makeConstraints { make in
            make.top.equalTo(populationTextCityLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(seasonView.snp.centerX).offset(-10)
            make.height.equalTo(20)
        }
        seasonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(seasonTextLabel.snp.centerY) 
            make.leading.equalTo(seasonView.snp.centerX).offset(-2)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        conditionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonTextLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(seasonView.snp.centerX).offset(-10)
            make.height.equalTo(20)
        }
        conditionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(conditionTextLabel.snp.centerY).offset(-1)
            make.leading.equalTo(seasonView.snp.centerX).offset(-2)
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        
        
        // MARK: - windView.snp.makeConstraints
        windView.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(18)
            make.leading.equalTo(cityView.snp.centerX).offset(-16)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        windSpeedTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-12)
            make.height.equalTo(20)
        }
        windSpeedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windSpeedTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        windGustTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-12)
            make.height.equalTo(20)
        }
        windGustLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windGustTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        windDirTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windGustTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-12)
            make.height.equalTo(20)
        }
        windDirLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windDirTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        pressureMmTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windDirTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-12)
            make.height.equalTo(20)
        }
        pressureMmLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pressureMmTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        
  
         
        // MARK: - collectionView.snp.makeConstraints
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(cityView.snp.bottom)
            make.height.equalTo(108)
        }
        
        factView.snp.makeConstraints { make in
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
    
    func reloadCollection() {
        collectionView.reloadData()
    }

    func configureCityView() {
        let model = presenter.createCityViewModel()
        
        if let data = model.countryFlag {
            let img = UIImage(data: data)
            imageView.image = img
        }
        
        nameCityLabel.text = model.cityName
        
        if model.isCapital {
            isCapitalImageView.isHidden = false
        }
        
        if model.populationOfCity == "" {
            populationTextCityLabel.isHidden = true
            populationCityLabel.isHidden = true
        } else {
            populationTextCityLabel.isHidden = false
            populationCityLabel.isHidden = false
            populationCityLabel.text = model.populationOfCity
        }
    }
    func configureWeatherView() {
        let model = presenter.createFactViewModel()
        seasonLabel.text = model.season
        conditionLabel.text = model.condition
        windSpeedLabel.text =  model.windSpeed
        windGustLabel.text = model.windGust
        windDirLabel.text = model.windDir
        pressureMmLabel.text = model.pressureMm
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
