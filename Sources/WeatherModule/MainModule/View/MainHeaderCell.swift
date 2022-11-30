//
//  File.swift
//  
//
//  Created by Данила on 30.11.2022.
//

import Foundation
import UIKit
import SnapKit

class HeaderView: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .black
        
        return label
    }()
    
    let activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.contentMode = .center
        
        return activity
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13

        return imageView
    }()
    
    func initialize() {
        
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.addSubview(activityView)
        self.addSubview(imageView)
        self.addSubview(headerLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(2)
            make.height.equalTo(-4)
            make.width.equalTo(26)
        }

        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(2)
            make.bottom.equalTo(-2)
            make.height.equalTo(-4)
            make.trailing.equalTo(-12)
        }

        activityView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(2)
            make.height.equalTo(-4)
            make.width.equalTo(26)
        }
    }
}
