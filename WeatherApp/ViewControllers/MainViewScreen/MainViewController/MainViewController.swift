//
//  ViewController.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 31.10.2023.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {

    var locationManager: CLLocationManager? = nil
    
    private lazy var sunView = MainHeader()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Подробнее на 24 часа", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        button.titleLabel?.attributedText =  NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return button
    }()
    
    private lazy var collection = MiniWeatherInfoCollection()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ежедневный прогноз"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var moredays: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "25 дней"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText =  NSMutableAttributedString(string: "25 дней", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    private lazy var dailyCollection = DailyCollectionView()
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        barButtunTune()
        layout()
        
    }

    //MARK: - Layout
    
    private func layout() {
        
        view.addSubview(sunView)
        view.addSubview(moreButton)
        view.addSubview(collection)
        view.addSubview(titleLabel)
        view.addSubview(moredays)
        view.addSubview(dailyCollection)
        
        sunView.translatesAutoresizingMaskIntoConstraints = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        dailyCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunView.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            sunView.heightAnchor.constraint(equalToConstant: 230),
            sunView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sunView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            moreButton.topAnchor.constraint(equalTo: sunView.bottomAnchor, constant: 33),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            moreButton.widthAnchor.constraint(equalToConstant: 174),
            moreButton.heightAnchor.constraint(equalToConstant: 20),
            
            collection.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 24),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            moredays.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            moredays.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 25),
            
            dailyCollection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dailyCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            dailyCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            dailyCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    //MARK: - Initialize
    
    init(locationManager: CLLocationManager?) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    //MARK: - BarButtonItems
    
    private func barButtunTune() {
        
        
        navigationController?.navigationBar.tintColor = .black
      
        let settingsBarButton = UIBarButtonItem(image: UIImage(named: "statistic"), style: .done, target: self, action: #selector(settingsButtonPressed))
        let locationBarButton = UIBarButtonItem(image: UIImage(named: "location"), style: .done, target: self, action: #selector(locationButtonPressed))
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.rightBarButtonItem = locationBarButton
    }
    
    
    //MARK: - Objc func

    @objc private func settingsButtonPressed() {
        let settingsViewControlle = SettingsViewController()
        navigationController?.pushViewController(settingsViewControlle, animated: true)
    }
    
    @objc private func locationButtonPressed() {
        let onboardViewCOntroller = OnBoardingViewController(locationManager: SceneDelegate().locationManager)
        onboardViewCOntroller.boardState = .reloadEntry
        navigationController?.pushViewController(onboardViewCOntroller, animated: true)
    }
    
}

