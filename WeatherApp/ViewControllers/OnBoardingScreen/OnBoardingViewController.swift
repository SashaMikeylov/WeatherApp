//
//  OnBoardingViewController.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 31.10.2023.
//

import UIKit
import CoreLocation

enum OnBoardState {
    case firstEntry
    case reloadEntry
}

final class OnBoardingViewController: UIViewController {
    
    var locationManager: CLLocationManager
    var boardState: OnBoardState = .firstEntry
    
    private lazy var girlImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboardGirl")
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = Text.onBoardTitle
        label.textColor = .white
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private lazy var descripText1: UILabel = {
        let label = UILabel()
        label.text = Text.onBoardingDescrip1
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descripText2: UILabel = {
        let label = UILabel()
        label.text = Text.onBoardingDescrip2
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var useButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(useButtonPressed), for: .touchUpInside)
        button.addButtonAnimation()
        
        return button
    }()
    
    private lazy var addLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.addTarget(self, action: #selector(addButtonPresed), for: .touchUpInside)
        button.addButtonAnimation()
        
        return button
    }()
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationItem.hidesBackButton = true
        layout()
    }
    
    //MARK: - Initialize
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func layout() {
        let elements = [girlImage, titleText, descripText1, descripText2, useButton, addLocationButton]
        elements.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            girlImage.heightAnchor.constraint(equalToConstant: 200),
            girlImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            girlImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -84),
            girlImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 111),
            
            titleText.topAnchor.constraint(equalTo: girlImage.bottomAnchor, constant: 50),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            descripText1.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 50),
            descripText1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descripText1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            descripText2.topAnchor.constraint(equalTo: descripText1.bottomAnchor, constant: 10),
            descripText2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descripText2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            addLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            addLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77),
            
            useButton.heightAnchor.constraint(equalToConstant: 40),
            useButton.bottomAnchor.constraint(equalTo: addLocationButton.topAnchor, constant: -25),
            useButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            useButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        
        ])
    }
    
    
    //MARK: - Objc func

    
    @objc private func useButtonPressed() {
        locationManager.delegate = self
        if locationManager.authorizationStatus != .authorizedAlways || locationManager.authorizationStatus != .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            let mainViewController = MainViewController(locationManager: locationManager)
            navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
    
    @objc private func addButtonPresed() {
        if boardState == .firstEntry {
            let mainViewController = MainViewController(locationManager: nil)
            navigationController?.pushViewController(mainViewController, animated: true)
        } else if boardState == .reloadEntry {
            navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - Extensions

extension OnBoardingViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            let mainViewController = MainViewController(locationManager: locationManager)
            navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print(locations)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
