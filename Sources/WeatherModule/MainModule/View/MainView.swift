//
//  ViewController.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    
    var tableView: UITableView { get set }
}

public class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Weather App"
        l.font = UIFont.preferredFont(forTextStyle: .title1)
        l.textAlignment = .center
        
        return l 
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35,
                                                                           weight: .semibold))
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        button.layer.cornerRadius = 25
        button.clipsToBounds = false
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(MainCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .clear
//        tv.keyboardDismissMode = .onDrag
    //    tv.separatorStyle = .singleLine
        
        return tv
    }()
    
    // MARK: - Initialize Method
    init(presenter: MainPresenterProtocol) {
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
    
    private func initialize() {
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(searchButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }

        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80.0)
            make.trailing.equalToSuperview().inset(55.0)
            make.height.equalTo(50.0)
            make.width.equalTo(50.0)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    @objc func didTapButton() {
        presenter?.didTapButton()
    }
}

extension MainViewController: MainViewProtocol {
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.countrys.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countrys[section].citysArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MainCell
        let city = presenter.countrys[indexPath.section].citysArray[indexPath.row]
        
        cell.configureCell(city: city)
        
        return cell
    }
    
    // MARK: - Headers Method
//    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return presenter.countrys[section].name
//    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        lazy var headerView: UIView = {
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0,
                                                      width: tableView.frame.width,
                                                      height: 50))
            view.backgroundColor = .gray
            view.layer.cornerRadius = 15.0
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.gray.cgColor
            
            return view
        }()
        
        lazy var countryImageView : UIImageView = {
            let img = UIImageView()
            img.backgroundColor = .red
            img.frame = CGRect.init(x: 2, y: 2,
                                    width: 26,
                                    height: 26)
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.layer.cornerRadius = 13
            img.clipsToBounds = true
            return img
        }()
        
        lazy var headerLabel: UILabel = {
            let label = UILabel()
            label.frame = CGRect.init(x: 30, y: -4,
                                      width: headerView.frame.width/1.5,
                                      height: headerView.frame.height-10)
            label.font = .systemFont(ofSize: 12)
            label.font = UIFont.preferredFont(forTextStyle: .title3)
            label.textColor = .black
            
            return label
        }()
        
        headerView.addSubview(countryImageView)
        headerView.addSubview(headerLabel)
        
        headerLabel.text = presenter.countrys[section].name
        
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
