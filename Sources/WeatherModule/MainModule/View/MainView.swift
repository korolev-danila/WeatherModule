//
//  ViewController.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import UIKit
import SnapKit

protocol MainViewInputProtocol: AnyObject {
    
    func reloadTableView()
}

protocol MainViewOutputProtocol {
    
    func start()
    
    func countrysCount() -> Int
    func sectionArrayCount(_ section: Int) -> Int
    func countryName(_ section: Int) -> String
    func countryFlag(_ section: Int) -> Data?
    
    func didTapButton()
    func showDetails(index: IndexPath)
    func deleteCity(for index: IndexPath)
    func deleteAll()
    func updateName(for index: IndexPath) -> String
    func updateTemp(for index: IndexPath) -> String
    func updateTime(for index: IndexPath) -> String
    func updateFlag(forSection section: Int )
}

public class MainViewController: UIViewController {
    
    let presenter: MainViewOutputProtocol
    
    // MARK: - Initialize Method
    init(presenter: MainViewOutputProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.start()
        initialize()
        settingNC()
    }
    
    private var deleteIsHidden = true {
        didSet {
            searchButton.isHidden = !deleteIsHidden
            searchButton.isEnabled = deleteIsHidden
        }
    }
    
    private let searchButton: UIButton = {
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
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MainCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    func settingNC() {
        self.navigationController?.navigationBar.topItem?.title = "Weather App"
        setEditButton()
    }
    
    func setEditButton() {
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTap))
        editButton.tintColor = .blue
        self.navigationController?.navigationBar.topItem?.setLeftBarButton(editButton, animated: true)
        self.navigationItem.setRightBarButton(nil, animated: true)
    }
    
    @objc func editButtonTap() {
        
        print("setEdit")
        deleteIsHidden = false
        tableView.reloadData()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        doneButton.tintColor = .blue
        self.navigationItem.setLeftBarButton(doneButton, animated: true)
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deleteButtonTap))
        deleteButton.tintColor = .red
        self.navigationItem.setRightBarButton(deleteButton, animated: true)
    }
    
    @objc func doneButtonTap() {
        setEditButton()
        deleteIsHidden = true
        tableView.reloadData()
    }
    
    @objc func deleteButtonTap() {
        deleteIsHidden = true
        presenter.deleteAll()
    }
    
    @objc func didTapButton() {
        presenter.didTapButton()
    }
}

extension MainViewController: MainViewInputProtocol {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    private func initialize() {
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(searchButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80.0)
            make.trailing.equalToSuperview().inset(55.0)
            make.height.equalTo(50.0)
            make.width.equalTo(50.0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.countrysCount()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        if deleteIsHidden {
            presenter.showDetails(index: indexPath)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sectionArrayCount(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MainCell
        
        cell.delegate = self
        
        cell.configureCell(name: presenter.updateName(for: indexPath),
                           temp: presenter.updateTemp(for: indexPath),
                           time: presenter.updateTime(for: indexPath),
                           deleteIsHidden: deleteIsHidden)
        
        return cell
    }
    
    // MARK: - Headers Method&UI
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = HeaderView()
        
        headerView.frame = CGRect.init(x: 0, y: 0,
                                       width: tableView.frame.width,
                                       height: 50)
        headerView.initialize()
        
        headerView.headerLabel.text = presenter.countryName(section)
        
        let imgData = presenter.countryFlag(section)
        
        if imgData != nil {
            if UIImage(data: imgData!) != nil {
                headerView.activityView.stopAnimating()
                headerView.imageView.image = UIImage(data: imgData!)!.resize(60)
            } else {
                presenter.updateFlag(forSection: section)
                headerView.activityView.startAnimating()
            }
        } else {
            if !headerView.activityView.isAnimating {
                headerView.activityView.startAnimating()
                presenter.updateFlag(forSection: section)
            }
        }
        
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - MainViewCellDelegate
extension MainViewController: MainViewCellDelegate {
    func delete(cell: MainCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            presenter.deleteCity(for: indexPath)
        }
    }
}

extension UIImage {
    func resize(_ max_size: CGFloat) -> UIImage {
        let max_size_pixels = max_size / UIScreen.main.scale
        let aspectRatio =  size.width/size.height
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        if aspectRatio > 1 {
            width = max_size_pixels
            height = max_size_pixels / aspectRatio
        } else {
            height = max_size_pixels
            width = max_size_pixels * aspectRatio
        }
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: UIGraphicsImageRendererFormat.default())
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return newImage
    }
}
