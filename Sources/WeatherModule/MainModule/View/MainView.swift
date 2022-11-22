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
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(MainCell.self, forCellReuseIdentifier: "cell")
        tv.keyboardDismissMode = .onDrag
        
        return tv
    }()
    
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
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(searchButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80.0)
            make.trailing.equalToSuperview().inset(55.0)
            make.height.equalTo(50.0)
            make.width.equalTo(50.0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.bottom.equalTo(view.snp_bottomMargin)
            make.leading.equalTo(view.snp_leadingMargin)
            make.trailing.equalTo(view.snp_trailingMargin)
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
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.citys.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MainCell
        let country = presenter.countrys[indexPath.row]
        
        cell.configureCell(city: country)
        
        return cell
    }
}
