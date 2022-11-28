//
//  File.swift
//  
//
//  Created by Данила on 26.11.2022.
//

import Foundation
import UIKit
import SnapKit
import WebKit

class CollectionCell: UICollectionViewCell {
    
  //  let vcWebDelegate = VCWebDelegate()
    
    lazy var webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = false
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let wv = WKWebView(frame: .zero, configuration: configuration)
        wv.scrollView.isScrollEnabled = false
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.contentMode = .center
        wv.backgroundColor = .clear
   //     wv.navigationDelegate = vcWebDelegate
        return wv
    }()
    
    lazy var iconActivityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.contentMode = .center
        
        return activity
    }()
    
    private let dayOfTheWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "Monday"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.05
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "27.11"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.05
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let tempView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dayTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Day:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Night:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dayTempLabel: UILabel = {
        let label = UILabel()
        label.text = "36"
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dayCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-12"
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        iconActivityView.startAnimating()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .white

        self.addSubview(dateLabel)
        self.addSubview(dayOfTheWeekLabel)
        self.addSubview(tempView)
        self.addSubview(webView)
        self.addSubview(iconActivityView)
        
        tempView.addSubview(dayTextLabel)
        tempView.addSubview(dayTempLabel)
        tempView.addSubview(dayCLabel)
        tempView.addSubview(nightTextLabel)
        tempView.addSubview(nightTempLabel)
        tempView.addSubview(nightCLabel)
        
        dayOfTheWeekLabel.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.leading.equalTo(5)
            make.trailing.equalTo(self.snp.centerX).offset(8)
            make.height.equalTo(12)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.trailing.equalTo(-5)
            make.leading.equalTo(dayOfTheWeekLabel.snp.trailing).offset(1)
            make.height.equalTo(12)
            
        }
        
        // MARK: - tempView.snp.makeConstraints
        tempView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(dayOfTheWeekLabel.snp.bottom).offset(4)
            make.height.equalTo(30)
        }
        
        dayTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(12)
            make.leading.equalToSuperview()
            make.trailing.equalTo(tempView.snp.centerX).offset(-4)
        }
        dayTempLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dayTextLabel.snp.bottom)
            make.height.equalTo(14)
            make.leading.equalTo(dayTextLabel.snp.trailing).offset(2)
            make.width.equalTo(20)
        }
        dayCLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTempLabel.snp.top)
            make.height.equalTo(12)
            make.leading.equalTo(dayTempLabel.snp.trailing)
        }
        
        nightTextLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTextLabel.snp.bottom)
            make.height.equalTo(12)
            make.leading.equalToSuperview()
            make.trailing.equalTo(tempView.snp.centerX).offset(-4)
        }
        nightTempLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nightTextLabel.snp.bottom)
            make.height.equalTo(14)
            make.leading.equalTo(nightTextLabel.snp.trailing).offset(2)
            make.width.equalTo(20)
        }
        nightCLabel.snp.makeConstraints { make in
            make.top.equalTo(nightTempLabel.snp.top)
            make.height.equalTo(12)
            make.leading.equalTo(nightTempLabel.snp.trailing)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(tempView.snp.bottom)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        iconActivityView.snp.makeConstraints { make in
            make.top.equalTo(tempView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func configureCell(weatherDay: Forecasts, heightOfCell: Double) {
        if weatherDay.parts?.dayShort?.temp != nil { dayTempLabel.text = "\(Int(weatherDay.parts?.dayShort?.temp! ?? 0))" }
        if weatherDay.parts?.nightShort?.temp != nil {nightTempLabel.text = "\(Int(weatherDay.parts?.nightShort?.temp! ?? 0))"}
        
        if weatherDay.date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let date = dateFormatter.date(from: weatherDay.date!)
            
            if date != nil {
                dateFormatter.dateFormat = "dd.MM"
                let dateStr = dateFormatter.string(from: date!)
                dateFormatter.dateFormat = "EEEE"
                let dayOfWeek = dateFormatter.string(from: date!)
                
                dateLabel.text = dateStr
                dayOfTheWeekLabel.text = dayOfWeek
            }
        }
         
        if weatherDay.svgStr != nil {
            webView.isHidden = true
            // Так и не смог понять как без сторонних библиотек вставить нормально svg
            let svgNew = """
<svg xmlns="http://www.w3.org/2000/svg" width="\(heightOfCell*2)" height="\(heightOfCell*2)" viewBox="0 2 28 28">
"""
            webView.loadHTMLString((svgNew + weatherDay.svgStr!), baseURL: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.webView.isHidden = false
                self.iconActivityView.stopAnimating()
            }
            

        } else {
            webView.isHidden = true
            iconActivityView.startAnimating()
        }
    }
}

//class VCWebDelegate: UIViewController, UIWebViewDelegate {
//
//    weak var cell: CollectionCell?
//
//    init() {
//        super.init(nibName: nil, bundle: nil)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//}

