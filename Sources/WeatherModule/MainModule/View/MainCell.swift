//
//  File.swift
//  
//
//  Created by Данила on 21.11.2022.
//

import Foundation
import UIKit

protocol MainViewCellDelegate: AnyObject {
    func delete(cell: MainCell)
}

class MainCell: UITableViewCell {
    
    weak var delegate: MainViewCellDelegate?
    
    var deleteIsHidden: Bool = true {
        didSet {
            deleteButton.isHidden = deleteIsHidden
            deleteButton.isEnabled = !deleteIsHidden
        }
    }
    
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
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "10:00"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let cLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private  let deleteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24,
                                                                           weight: .semibold))
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .red
        button.layer.cornerRadius = 25
        button.clipsToBounds = false
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init( style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteButtonTap() {
        delegate?.delete(cell: self)
    }
    
    func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(deleteButton)
        self.addSubview(nameLabel)
        self.addSubview(tempLabel)
        self.addSubview(cLabel)
        self.addSubview(timeLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.trailing.equalTo(self.snp.centerX)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(-15)
            make.width.equalTo(self.snp.height)
            make.height.equalTo(self.snp.height)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(cLabel.snp.leading)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        
        cLabel.snp.makeConstraints { make in
            make.trailing.equalTo(timeLabel.snp.leading).offset(-10)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-8)
            make.width.equalTo(50)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        
    }
    
    func configureCell(city: City, time: String, deleteIsHidden: Bool) {
        nameLabel.text = city.name
        tempLabel.text = "\(Int(city.timeAndTemp.temp))"
        timeLabel.text = time
        self.deleteIsHidden = deleteIsHidden
    }
}
