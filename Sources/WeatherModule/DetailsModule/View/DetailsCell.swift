//
//  File.swift
//  
//
//  Created by Данила on 26.11.2022.
//

import Foundation
import UIKit
import SnapKit

class CollectionCell: UICollectionViewCell {
    
    
    private let dayOfTheWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "Monday"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "27.11"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private let imageView: UIImageView = {
        let iView = UIImageView()
        iView.backgroundColor = .yellow
        iView.contentMode = .scaleAspectFit
        iView.translatesAutoresizingMaskIntoConstraints = false
        
        return iView
    }()
    
    private let tempView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dayTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Day:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Night:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dayTempLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dayCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightTempLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .white

        self.addSubview(dateLabel)
        self.addSubview(dayOfTheWeekLabel)
        self.addSubview(tempView)
        self.addSubview(imageView)
        
        tempView.addSubview(dayTextLabel)
        tempView.addSubview(dayTempLabel)
        tempView.addSubview(dayCLabel)
        tempView.addSubview(nightTextLabel)
        tempView.addSubview(nightTempLabel)
        tempView.addSubview(nightCLabel)
        
        dayOfTheWeekLabel.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.leading.equalTo(6)
            make.trailing.equalTo(self.snp.centerX).offset(8)
            make.height.equalTo(14)
       //     make.width.equalTo(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.trailing.equalTo(-6)
            make.leading.equalTo(dayOfTheWeekLabel.snp.trailing).offset(2)
            make.height.equalTo(14)
            
        }
        
        // MARK: - tempView.snp.makeConstraints
        tempView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(dayOfTheWeekLabel.snp.bottom).offset(6)
            make.height.equalTo(30)
        }
        
        dayTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(12)
            make.leading.equalToSuperview()
            make.trailing.equalTo(tempView.snp.centerX)
        }
        dayTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(12)
            make.leading.equalTo(dayTextLabel.snp.trailing).offset(2)
            make.width.equalTo(14)
        }
        dayCLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(12)
            make.leading.equalTo(dayTempLabel.snp.trailing)
        }
        
        nightTextLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTextLabel.snp.bottom).offset(2)
            make.height.equalTo(12)
            make.leading.equalToSuperview()
            make.trailing.equalTo(tempView.snp.centerX)
        }
        nightTempLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTextLabel.snp.bottom).offset(4)
            make.height.equalTo(12)
            make.leading.equalTo(nightTextLabel.snp.trailing).offset(2)
            make.width.equalTo(14)
        }
        nightCLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTextLabel.snp.bottom).offset(4)
            make.height.equalTo(12)
            make.leading.equalTo(nightTempLabel.snp.trailing)
        }
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(tempView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        
        
        
        
//        tempLabel.snp.makeConstraints { make in
//            make.trailing.equalTo(cLabel.snp.leading)
//            make.top.equalTo(2)
//            make.bottom.equalTo(-2)
//        }
//
//        cLabel.snp.makeConstraints { make in
//            make.trailing.equalTo(timeLabel.snp.leading).offset(-10)
//            make.top.equalTo(2)
//            make.bottom.equalTo(-2)
//        }
//
//        timeLabel.snp.makeConstraints { make in
//            make.trailing.equalTo(-8)
//            make.width.equalTo(50)
//            make.top.equalTo(2)
//            make.bottom.equalTo(-2)
//        }
        
    }
    
//    func configureCell(city: City, time: String, deleteIsHidden: Bool) {
//        nameLabel.text = city.name
//        tempLabel.text = "\(Int(city.timeAndTemp.temp))"
//        timeLabel.text = time
//        self.deleteIsHidden = deleteIsHidden
//    }
}
