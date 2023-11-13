//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 02.11.2023.
//

import UIKit




final class SettingsViewController: UIViewController {
    
   private let settingsView = SettingsView()
    
    
    //MARK: - Life
    
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.navigationController = navigationController
        navigationItem.hidesBackButton = true
        
    }
    
}
