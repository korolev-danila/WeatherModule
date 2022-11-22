//
//  File.swift
//  
//
//  Created by Данила on 21.11.2022.
//

import Foundation
import UIKit


class MainCell: UITableViewCell {
     
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Name label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let countryLabel: UILabel = {
       let label = UILabel()
        label.text = "Country label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init( style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(nameLabel)
        self.addSubview(countryLabel)

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.trailing.equalTo(self.snp.centerX)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        countryLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX)
            make.trailing.equalTo(-10)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
    }
    
    func configureCell(city: City) {
        nameLabel.text = city.name
    }
}
