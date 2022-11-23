//
//  SearchView.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

import UIKit
import SnapKit

protocol SearchViewProtocol: AnyObject {
    
    var textField: UITextField { get set }
    var tableView: UITableView { get set }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}

public class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol!
    
    var search: String = ""
    
    lazy var activityView: UIActivityIndicatorView = {
        
        let act = UIActivityIndicatorView(style: .large)
        
        return act
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search City"
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.layer.cornerRadius = 15.0
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        tf.borderStyle = UITextField.BorderStyle.none
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = UITextField.ViewMode.always
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        
        return tf
    }()
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(SearchCell.self, forCellReuseIdentifier: "cell")
        tv.keyboardDismissMode = .onDrag
       // tv.sele
        
        return tv
    }()
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        textField.becomeFirstResponder()
    }
}

extension SearchViewController: SearchViewProtocol {
    
    private func initialize() {
        
        view.backgroundColor = .white
        
        view.addSubview(textField)
        view.addSubview(tableView)
        view.addSubview(activityView)
        
        activityView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-75)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(55)
            make.bottom.equalTo(view.snp_bottomMargin)
            make.leading.equalTo(view.snp_leadingMargin)
            make.trailing.equalTo(view.snp_trailingMargin)
        }
    }
    
    // MARK: - ActivityIndicator method
    func showActivityIndicator() {
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityView.stopAnimating()
    }
}

// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            if let text = textField.text {
                search = String(text.dropLast())
            } else {
                print("error if let text")
            }
        } else {
            if let text = textField.text {
                search = text + string
            } else {
                print("error if let text")
            }
        }
        
        presenter.fetchCitys(search)
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
        
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        hideActivityIndicator()
        search = ""
        return true
    }
}

// MARK: - TableViewController Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.save(indexPath)
        self.dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.citys.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SearchCell
        let city = presenter.citys[indexPath.row]
        
        cell.configureCell(city: city)
        
        return cell
    }
}
