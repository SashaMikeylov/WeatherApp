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
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        barButtunTune()
        view.addSubview(sunView)
        sunView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sunView.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            sunView.heightAnchor.constraint(equalToConstant: 300),
            sunView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sunView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
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

