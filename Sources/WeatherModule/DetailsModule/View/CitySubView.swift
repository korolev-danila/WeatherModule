//
//  File.swift
//  
//
//  Created by Данила on 05.12.2022.
//

import Foundation
import UIKit
import SnapKit

class CitySubView: UIView {
    
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
    
    public func initialize() {
        
      //  self.addSubview(view)
        
        self.addSubview(nameCityLabel)
        self.addSubview(isCapitalImageView)

        self.addSubview(seasonView)
        self.addSubview(windView)
        
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
            make.trailing.equalTo(self.snp.centerX).offset(-10)
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
            make.leading.equalTo(self.snp.centerX).offset(-16)
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
  
    }
    
    public func configureCityView(_ model: CityViewModel) {
        
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
    
    public func configureWeatherView(_ model: FactViewModel) {
        
        seasonLabel.text = model.season
        conditionLabel.text = model.condition
        windSpeedLabel.text =  model.windSpeed
        windGustLabel.text = model.windGust
        windDirLabel.text = model.windDir
        pressureMmLabel.text = model.pressureMm
    }
    
}
