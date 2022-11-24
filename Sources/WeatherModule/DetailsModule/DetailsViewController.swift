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
        settingNC()
       
 //       initialize()
    }
    
    func settingNC() {
                
        let button = UIButton(type: .system)
    //    button.backgroundColor = .blue
        let image = UIImage(systemName: "chevron.left",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35,
                                                                           weight: .semibold))
        button.layer.cornerRadius = 22
        button.clipsToBounds = false
        button.imageView?.tintColor = .blue
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: button)
        barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButton.customView?.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.width.equalTo(50.0)
        }
//        barButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        barButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        self.navigationItem.leftBarButtonItem = barButton
        self.navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    @objc func backButtonTapped() {
        presenter.router.popVC()
    }
    
}

extension DetailsViewController: DetailsViewProtocol {
    
}
