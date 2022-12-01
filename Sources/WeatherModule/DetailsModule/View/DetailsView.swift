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
    func countryFlag() -> Data?
    func cityName() -> String
    func isCapital() -> Bool
    func populationOfCity() -> String
    func forecastCount() -> Int
    
    func factSeason() -> String
    func factCondition() -> String
    func factWindSpeed() -> String
    func factWindGust() -> String
    func factWindDir() -> String
    func factPressureMm() -> String
    
    func updateCell(heightOfCell: Double,
                    index: IndexPath) -> (dayTemp: String, nightTemp: String,
                                          date: String, week: String, svgStr: String?)
}


public class DetailsViewController: UIViewController {
    
    let presenter: DetailsViewOutputProtocol
    
    let barButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.left",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35,
                                                                           weight: .semibold))
        button.layer.cornerRadius = 22
        button.clipsToBounds = false
        button.imageView?.tintColor = .blue
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    let imageView: UIImageView = {
        let iView = UIImageView()
        iView.backgroundColor = .yellow
        iView.contentMode = .scaleAspectFit
        iView.translatesAutoresizingMaskIntoConstraints = false
        
        return iView
    }()
    
    let bigView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    // MARK: - cityView
    let cityView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let data = presenter.countryFlag() {
            let img = UIImage(data: data)
            imageView.image = img?.resize(60)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var nameCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "Name of City"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let isCapitalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        
        return imageView
    }()
    
    var populationTextCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
       // label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.textAlignment  = .right
        label.text = "Population:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let populationCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.textAlignment  = .left
        label.text = "999999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    

    // MARK: - seasonView
    let seasonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let seasonTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment  = .right
        label.text = "Season:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let seasonLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment  = .left
        label.text = "summer"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let conditionTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment  = .right
        label.text = "Condition:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let conditionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
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
    let windView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let windSpeedTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Wind speed:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "120 m/c"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let windGustTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Wind gust:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let windGustLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "120 m/c"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let windDirTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Direction:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let windDirLabel: UILabel = {
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
    
    let pressureMmTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.text = "Pressure:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let pressureMmLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "100 mm"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.delegate = self
        collection.dataSource = self
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    // MARK: - factView
    let factView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
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
        
        view.addSubview(imageView)
        view.addSubview(bigView)
        
        bigView.addSubview(cityView)
        bigView.addSubview(collectionView)
        bigView.addSubview(factView)
        
        cityView.addSubview(flagImageView)
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
 
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        bigView.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(imageView.snp.bottom).offset(-5)
            make.bottom.equalTo(0)
        }
        
        
        
        // MARK: - cityView.snp.makeConstraints
        cityView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 6)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.top.equalTo(6)
            make.height.equalTo(26)
            make.width.equalTo(26)
        }
        nameCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(6)
            make.top.equalTo(6)
            make.height.equalTo(26)
        }
        isCapitalImageView.snp.makeConstraints { make in
            make.leading.equalTo(nameCityLabel.snp.trailing).offset(6)
            make.top.equalTo(6)
            make.centerY.equalTo(nameCityLabel.snp.centerY)
        }
        
        
        
        // MARK: - seasonView.snp.makeConstraints
        seasonView.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cityView.snp.centerX)
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
            make.centerY.equalTo(seasonTextLabel.snp.centerY).offset(-1)
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
            make.leading.equalTo(cityView.snp.centerX).offset(-12)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        windSpeedTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX).offset(-2)
            make.height.equalTo(20)
        }
        windSpeedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windSpeedTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(2)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        windGustTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX).offset(-2)
            make.height.equalTo(20)
        }
        windGustLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windGustTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(2)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        windDirTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windGustTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX).offset(-2)
            make.height.equalTo(20)
        }
        windDirLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windDirTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(2)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        pressureMmTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windDirTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX).offset(-2)
            make.height.equalTo(20)
        }
        pressureMmLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pressureMmTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(2)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        
        
         
        // MARK: - collectionView.snp.makeConstraints
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(4)
            make.top.equalTo(cityView.snp.bottom)
            make.height.equalTo(108)
        }
        
        // MARK: - factView.snp.makeConstraints
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
        nameCityLabel.text = presenter.cityName()
        if presenter.isCapital() {
            isCapitalImageView.isHidden = false
        }
        if presenter.populationOfCity() == "" {
            populationTextCityLabel.isHidden = true
            populationCityLabel.isHidden = true
        } else {
            populationTextCityLabel.isHidden = false
            populationCityLabel.isHidden = false
            populationCityLabel.text = presenter.populationOfCity()
        }
    }
    func configureWeatherView() {
        seasonLabel.text = presenter.factSeason()
        conditionLabel.text = presenter.factSeason()
        windSpeedLabel.text =  presenter.factWindSpeed()
        windGustLabel.text = presenter.factWindGust()
        windDirLabel.text = presenter.factWindDir()
        pressureMmLabel.text = presenter.factPressureMm()
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

        let update = presenter.updateCell(heightOfCell: 100, index: indexPath)
        cell.configureCell(dayTemp: update.dayTemp, nightTemp: update.nightTemp,
                           date: update.date, week: update.week, svgStr: update.svgStr)
        
        return cell
    }
}
