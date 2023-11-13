//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 07.11.2023.
//

import Foundation
import UIKit


final class SettingsView: UIView {

    var navigationController: UINavigationController?
    
    private lazy var settingsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Настройки"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private lazy var settingsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.1
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    private lazy var instalButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Установить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addButtonAnimation()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private var settingsTune: [UserSettingsService.SettingsValue: Bool] = [
        .isCelcia: UserSettingsService.isCelcia,
        .isMile: UserSettingsService.isMile,
        .isTwelve: UserSettingsService.isTwelve,
        .isNotify: UserSettingsService.isNotify
    ]
    
    
    //MARK: - Segment elements
    
    private let tempetaruSegment = CustomSegmentView(segmentTitle: "Температура", segmentPropertyLeft: "C", segmentPropertyRight: "F", selected: UserSettingsService.isCelcia ? 0 : 1)
    
    private let speedSegment = CustomSegmentView(segmentTitle: "Скорость ветра", segmentPropertyLeft: "Mi", segmentPropertyRight: "Km", selected: UserSettingsService.isMile ? 0 : 1)
    
    private let formatSegment = CustomSegmentView(segmentTitle: "Формат времени", segmentPropertyLeft: "12", segmentPropertyRight: "24", selected: UserSettingsService.isTwelve ? 0 : 1)
    
    private let notifySegment = CustomSegmentView(segmentTitle: " Уведомления", segmentPropertyLeft: "On", segmentPropertyRight: "Off", selected: UserSettingsService.isNotify ? 0 : 1)
    
    //MARK: - Clouds
     
     private lazy var cloud1 = UIImageView(image: UIImage(named: "cloud0"))
     private lazy var cloud2 = UIImageView(image: UIImage(named: "cloud1"))
     private lazy var cloud3 = UIImageView(image: UIImage(named: "cloud2"))
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "backgroundColor")
        layout()
        cloudeAnimation()
        confirmSegments()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Layout
    
    private func layout() {
        
        let clouds = [cloud1, cloud2, cloud3]
        clouds.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        addSubview(settingsView)
        settingsView.addSubview(settingsTitle)
        settingsView.addSubview(tempetaruSegment)
        settingsView.addSubview(speedSegment)
        settingsView.addSubview(formatSegment)
        settingsView.addSubview(notifySegment)
        settingsView.addSubview(instalButton)
        
        NSLayoutConstraint.activate([
            
            settingsView.heightAnchor.constraint(equalToConstant: 400),
            settingsView.widthAnchor.constraint(equalToConstant: 350),
            settingsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            settingsTitle.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 25),
            settingsTitle.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 30),
            
            tempetaruSegment.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            tempetaruSegment.topAnchor.constraint(equalTo: settingsTitle.topAnchor, constant: 35),
            
            speedSegment.topAnchor.constraint(equalTo: tempetaruSegment.bottomAnchor, constant: 10),
            speedSegment.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            
            formatSegment.topAnchor.constraint(equalTo: speedSegment.bottomAnchor, constant: 10),
            formatSegment.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            
            notifySegment.topAnchor.constraint(equalTo: formatSegment.bottomAnchor, constant: 10),
            notifySegment.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            
            instalButton.heightAnchor.constraint(equalToConstant: 50),
            instalButton.widthAnchor.constraint(equalToConstant: 300),
            instalButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20),
            instalButton.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            
            cloud1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            cloud1.centerYAnchor.constraint(equalTo: centerYAnchor),
            cloud1.heightAnchor.constraint(equalToConstant: 100),
            cloud1.widthAnchor.constraint(equalToConstant: 300),
            
            cloud2.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            cloud2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            cloud2.heightAnchor.constraint(equalToConstant: 100),
            cloud2.widthAnchor.constraint(equalToConstant: 300),
            
            cloud3.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            cloud3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            cloud3.heightAnchor.constraint(equalToConstant: 100),
            cloud3.widthAnchor.constraint(equalToConstant: 250),
            
        ])
    }
    
    //MARK: - Func
    
    private func cloudeAnimation() {
        UIView.animate(withDuration: 30, animations: {
            self.cloud1.frame.origin.x -= 350
            self.cloud2.frame.origin.x += 200
            self.cloud3.frame.origin.x += 150
        })
    }
    
    private func confirmSegments() {
        let segments = [tempetaruSegment, formatSegment, speedSegment, notifySegment]
        segments.forEach {
            $0.customSegmentDelegate = self
        }
    }
    
    //MARK: - Objc func
    
    @objc private func buttonPressed() {
        UserSettingsService.isCelcia = settingsTune[.isCelcia]!
        UserSettingsService.isMile = settingsTune[.isMile]!
        UserSettingsService.isTwelve = settingsTune[.isTwelve]!
        UserSettingsService.isNotify = settingsTune[.isNotify]!
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extensions

extension SettingsView: SettingsProtocol {
    func segmentValue(value: String) {
        switch value {
        case "F": settingsTune[.isCelcia] = false
        case "C": settingsTune[.isCelcia] = true
        case "Mi": settingsTune[.isMile] = true
        case "Km": settingsTune[.isMile] = false
        case "12": settingsTune[.isTwelve] = true
        case "24": settingsTune[.isTwelve] = false
        case "On": settingsTune[.isNotify] = true
        case "Off": settingsTune[.isNotify] = false
        default: return
        }
    }
}

