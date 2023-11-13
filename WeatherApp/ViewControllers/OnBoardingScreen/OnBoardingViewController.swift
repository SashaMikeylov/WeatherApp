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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "onboardGirl")
        
        return image
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = onBoardTitle
        label.textColor = .white
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private lazy var descripText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = onBoardingDescrip
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var useButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(useButtonPressed), for: .touchUpInside)
        button.addButtonAnimation()
        
        return button
    }()
    
    private lazy var addLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(girlImage)
        view.addSubview(titleText)
        view.addSubview(descripText)
        view.addSubview(useButton)
        view.addSubview(addLocationButton)
        
        NSLayoutConstraint.activate([
            girlImage.heightAnchor.constraint(equalToConstant: 400),
            girlImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            girlImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            girlImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            titleText.topAnchor.constraint(equalTo: girlImage.bottomAnchor, constant: 40),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            descripText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 5),
            descripText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descripText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            useButton.heightAnchor.constraint(equalToConstant: 50),
            useButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            useButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            useButton.topAnchor.constraint(equalTo: descripText.bottomAnchor, constant: 25),
            
            addLocationButton.topAnchor.constraint(equalTo: useButton.bottomAnchor, constant: 15),
            addLocationButton.heightAnchor.constraint(equalToConstant: 50),
            addLocationButton.widthAnchor.constraint(equalToConstant: 300),
            addLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
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
