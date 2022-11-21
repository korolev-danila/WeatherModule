//
//  File.swift
//  
//
//  Created by Данила on 20.11.2022.
//

import Foundation
import UIKit
import SnapKit

protocol SearchCellProtocol {
    
    func setupViews()
}

class SearchCell: UITableViewCell, SearchCellProtocol {
     
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Name label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
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
        label.minimumScaleFactor = 0.2
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
            make.leading.equalTo(10)
            make.bottom.equalTo(-5)
        }
        countryLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.bottom.equalTo(-5)
        }
    }
    
    func configureCell(city: City) {
        nameLabel.text = city.name
        countryLabel.text = city.country
    }
}
