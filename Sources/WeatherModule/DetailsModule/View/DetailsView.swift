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
    
    let shimmerView = ShimmerView()
    let viewS = UIView()
    
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
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - cityView
    let cityView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let nameCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.text = "Name of City"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let populationTextCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.text = "Population:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let populationCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.text = "999999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let tempCityLabel: UILabel = {
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
    
    let cCityLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment  = .right
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
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
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
        
        view.backgroundColor = .white
       
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
        
        cityView.addSubview(tempCityLabel)
        cityView.addSubview(cCityLabel)
        
        
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
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        
        
        nameCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(6)
            make.top.equalTo(6)
        }
        
        populationTextCityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(8)
            make.leading.equalTo(6)
        }
        
        populationCityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(8)
            make.leading.equalTo(populationTextCityLabel.snp.trailing).offset(4)
        }
        
        tempCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(6)
            make.top.equalTo(populationTextCityLabel.snp.bottom).offset(8)
        }
        
        cCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(tempCityLabel.snp.trailing)
            make.bottom.equalTo(tempCityLabel)
        }
        
         
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(5)
            make.top.equalTo(cityView.snp.bottom)
            make.height.equalTo(58)
        }
        
        // MARK: - factView.snp.makeConstraints
        factView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        cell.backgroundColor = UIColor.blue
        
//        cell.snp.makeConstraints { make in
//            make.height.equalTo(44)
//            make.width.equalTo(44)
//        }
        
        return cell
    }
}
