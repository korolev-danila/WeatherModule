//
//  File.swift
//  
//
//  Created by Данила on 30.11.2022.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 12)
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .black
        
        return label
    }()
    
    private let activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.contentMode = .center
        
        return activity
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13

        return imageView
    }()
    
    
    // MARK: - init
    override init( frame: CGRect) {
        super.init(frame: frame)
        
        setupViews(frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(_ heightOfCell: CGFloat) {
        
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.addSubview(activityView)
        self.addSubview(imageView)
        self.addSubview(headerLabel)
        
        activityView.frame = CGRect(x: 1, y: 1,
                                    width: heightOfCell / 2 - 2,
                                    height: heightOfCell / 2 - 2)

        imageView.frame = CGRect(x: 1, y: 1,
                                 width: heightOfCell / 2 - 2,
                                 height: heightOfCell / 2 - 2)

        headerLabel.frame = CGRect(x: heightOfCell / 2, y: 0,
                                   width: self.frame.width - heightOfCell*1.25,
                                   height: heightOfCell  / 2)
    }
    
    public func settingCell(_ viewModel: HeaderCellViewModel) {
        
        headerLabel.text = viewModel.name
        
        if let image = UIImage(data: viewModel.imgData)  {
            activityView.stopAnimating()
            imageView.image = image.resize(60)
        } else {
            activityView.startAnimating()
        }
    }
}
