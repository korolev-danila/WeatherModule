//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import UIKit
import SnapKit

protocol DetailsViewProtocol: AnyObject {
    
}

public class DetailsViewController: UIViewController {
    
    var presenter: DetailsPresenterProtocol!
    
  //  let shimmerView = ShimmerView()
   // let viewS = UIView()
    
    /*
     Optional(WeatherModule.Fact(temp: Optional(10.0), feelsLike: Optional(3.0), icon: Optional("bkn_n"), condition: Optional("cloudy"), windSpeed: Optional(7.0), windGust: Optional(4.8), windDir: Optional("e"), pressureMm: Optional(764.0), pressurePa: Optional(1018.0), humidity: Optional(44.0), daytime: Optional("n"), polar: Optional(false), season: Optional("autumn"), precType: Optional(0.0), precStrength: Optional(0.0), isThunder: Optional(false), cloudness: Optional(0.5), obsTime: Optional(1669561200.0), phenomIcon: nil, phenomCondition: nil))
     
     windSpeed
     windGust
     windDir
     pressureMm
     
     
     cloudness enum
     0 — ясно.
     0.25 — малооблачно.
     0.5 — облачно с прояснениями.
     0.75 — облачно с прояснениями.
     1 — пасмурно.
     
     condition enum
     clear — ясно.
     partly-cloudy — малооблачно.
     cloudy — облачно с прояснениями.
     overcast — пасмурно.
     drizzle — морось.
     light-rain — небольшой дождь.
     rain — дождь.
     moderate-rain — умеренно сильный дождь.
     heavy-rain — сильный дождь.
     continuous-heavy-rain — длительный сильный дождь.
     showers — ливень.
     wet-snow — дождь со снегом.
     light-snow — небольшой снег.
     snow — снег.
     snow-showers — снегопад.
     hail — град.
     thunderstorm — гроза.
     thunderstorm-with-rain — дождь с грозой.
     thunderstorm-with-hail — гроза с градом.
     
     
     season
     */
    
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
    
    let nameCityLabel: UILabel = {
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
    
    let populationTextCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Population:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let populationCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .center
        label.text = "summer"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let cloudnessTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment  = .right
        label.text = "Cloud:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let cloudnessLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "not cloudness"
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
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "thunderstorm-with-rain"
        label.textAlignment  = .center
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
        label.textAlignment  = .right
        label.text = "Direction:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let windDirLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "southwest"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let pressureMmTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
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
    
//
//    let tempCityLabel: UILabel = {
//        let label = UILabel()
//        label.text = "0"
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.adjustsFontSizeToFitWidth = true
//        label.numberOfLines = 3
//        label.minimumScaleFactor = 0.02
//        label.baselineAdjustment = .alignBaselines
//        label.textAlignment  = .right
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//    let cCityLabel: UILabel = {
//        let label = UILabel()
//        label.text = "\u{2103}"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textAlignment  = .right
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
    
    
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
    
    
    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
       
        initialize()
    }
    
    func initialize() {
        print("initialize")
        view.backgroundColor = .white
        
        // shimmerView.backgroundColor = .yellow
       // shimmerView.translatesAutoresizingMaskIntoConstraints = false
       // view.addSubview(shimmerView)
        view.addSubview(imageView)
        view.addSubview(bigView)
        
        bigView.addSubview(cityView)
        bigView.addSubview(collectionView)
        bigView.addSubview(factView)
        
        cityView.addSubview(nameCityLabel)
        cityView.addSubview(populationTextCityLabel)
        cityView.addSubview(populationCityLabel)
        cityView.addSubview(seasonView)
        cityView.addSubview(windView)
        
        seasonView.addSubview(seasonTextLabel)
        seasonView.addSubview(seasonLabel)
        seasonView.addSubview(cloudnessTextLabel)
        seasonView.addSubview(cloudnessLabel)
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
            make.height.equalTo(UIScreen.main.bounds.height / 4)
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
            make.height.equalTo(UIScreen.main.bounds.height / 5.2)
        }
        
        
        nameCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.top.equalTo(6)
        }
        
        populationTextCityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(16)
            make.leading.equalTo(12)
        }
        
        populationCityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(16)
            make.leading.equalTo(populationTextCityLabel.snp.trailing).offset(4)
        }
        
        // MARK: - seasonView.snp.makeConstraints
        seasonView.snp.makeConstraints { make in
            make.top.equalTo(populationTextCityLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cityView.snp.centerX)
            make.bottom.equalToSuperview()
        }
        seasonTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(seasonView.snp.centerX).offset(-10)
            make.height.equalTo(20)
        }
        seasonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(seasonView.snp.centerX).offset(-2)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        cloudnessTextLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(seasonView.snp.centerX).offset(-10)
            make.height.equalTo(20)
        }
        cloudnessLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonTextLabel.snp.bottom).offset(4)
            make.leading.equalTo(seasonView.snp.centerX).offset(-2)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        conditionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(cloudnessTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(seasonView.snp.centerX).offset(-10)
            make.height.equalTo(20)
        }
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(cloudnessTextLabel.snp.bottom).offset(4)
            make.leading.equalTo(conditionTextLabel.snp.trailing).offset(-2)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        // MARK: - windView.snp.makeConstraints
        windView.snp.makeConstraints { make in
            make.top.equalTo(populationTextCityLabel.snp.bottom).offset(8)
            make.leading.equalTo(cityView.snp.centerX).offset(-12)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        windSpeedTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX)
            make.height.equalTo(20)
        }
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(windView.snp.centerX).offset(6)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        windGustTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX)
            make.height.equalTo(20)
        }
        windGustLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedTextLabel.snp.bottom).offset(4)
            make.leading.equalTo(windView.snp.centerX).offset(6)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        windDirTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windGustTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX)
            make.height.equalTo(20)
        }
        windDirLabel.snp.makeConstraints { make in
            make.top.equalTo(windGustTextLabel.snp.bottom).offset(4)
            make.leading.equalTo(windView.snp.centerX).offset(6)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        pressureMmTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windDirTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalTo(windView.snp.centerX)
            make.height.equalTo(20)
        }
        pressureMmLabel.snp.makeConstraints { make in
            make.top.equalTo(windDirTextLabel.snp.bottom).offset(4)
            make.leading.equalTo(windView.snp.centerX).offset(6)
            make.trailing.equalToSuperview()
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
        
        
        
        //shimmerView.startAnimating()
    }
    
//    func settingNC() {
//
//        let button = UIButton(type: .system)
//        let image = UIImage(systemName: "chevron.left",
//                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35,
//                                                                           weight: .semibold))
//        button.layer.cornerRadius = 22
//        button.clipsToBounds = false
//        button.imageView?.tintColor = .blue
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//
//        let barButton = UIBarButtonItem(customView: button)
//        barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
//        barButton.customView?.snp.makeConstraints { make in
//            make.height.equalTo(50.0)
//            make.width.equalTo(50.0)
//        }
//
//        self.navigationItem.leftBarButtonItem = barButton
//        self.navigationItem.leftBarButtonItem?.isEnabled = true
//    }
    
    @objc func backButtonTapped() {
        presenter.router.popVC()
    }
}

extension DetailsViewController: DetailsViewProtocol {
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 80, height: 100)
        }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }
}
