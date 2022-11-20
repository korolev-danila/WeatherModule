//
//  SearchView.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

import UIKit
import SnapKit

// https://debash.medium.com/uisearchcontroller-48dbc0f4cb63

protocol SearchViewProtocol: AnyObject {
    
}

public class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    var timer: Timer?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {

        view.backgroundColor = .blue

//        let textField = UITextField()
//
//        textField.snp.makeConstraints { make in
//            make.top.equalTo(0)
//            make.leading.equalTo(10)
//            make.trailing.equalTo(10)
//        }
    }
//
//    let searchBar = UISearchBar()
//    private let bag = DisposeBag()
//
//    var errorView: UIView? {
//        return nil
//    }
//
//    var loadingView: UIView? {
//        return nil
//    }
//
//    var contentView: UIView {
//        fatalError("ContentView needs to be overriden")
//    }
//
//    init(presenter: SearchPresenterProtocol) {
//        self.presenter = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureSearchBar()
//
//        // initial state
//        errorView?.isHidden = true
//        loadingView?.isHidden = true
//    }
//
//    private func configureSearchBar() {
//        searchBar.barStyle = .default
//        view.addSubview(searchBar)
//
//        searchBar.snp.makeConstraints { make in
//            make.top.equalTo(0)
//            make.bottom.equalTo(0)
//            make.leading.equalTo(0)
//            make.trailing.equalTo(0)
//        }
//
//    }
    
    //
    //    private let tableView: UITableView = {
    //        let tableView = UITableView()
    //        tableView.backgroundColor = .white
    //        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
    //        tableView.translatesAutoresizingMaskIntoConstraints = false
    //        return tableView
    //    }()
    //
    //    private let searchController = UISearchController(searchResultsController: nil)
    //
    //    private func setupViews() {
    //        view.backgroundColor = .white
    //        view.addSubview(tableView)
    //    }
    //
    //    private func setupDelegate() {
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //
    //        searchController.searchBar.delegate = self
    //    }
}

extension SearchViewController: SearchViewProtocol {
    
}
//
////MARK: - UITableViewDataSourse
//extension SearchViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        albums.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
//        let album = albums[indexPath.row]
//        cell.configureAlbumCell(album: album)
//        return cell
//    }
//}
//
////MARK: - UITableViewDelegate
//extension SearchViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        70
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt" )
//    }
//}
//
////MARK: - UISearcheBarDelegate
//extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//
//        if text != "" {
//            timer?.invalidate()
//            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
//
//            })
//        }
//    }
//}
