//
//  MainHeader.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 09.11.2023.
//

import UIKit

final class MainHeader: UIView {
    
    private lazy var yellowLine: UIImageView = {
        let line = UIImageView()
        line.image = UIImage(named: "elipse")
        line.backgroundColor = .clear
        
        return line
    }()
    
    private lazy var sunSetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunset_yellow")
        
        return imageView
    }()
    
    private lazy var sunRiseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunrise_yellow")
        
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private lazy var nowTemperature = TemperatureLabel(frame: .zero, 
                                                       text: "16",
                                                       font: UIFont.systemFont(ofSize: 35, weight: .medium), textColor: .white,
                                                       degreeSize: 8)
    
    private lazy var minTemp = TemperatureLabel(frame: .zero,
                                                text: "6", font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                textColor: .white,
                                                degreeSize: 6)
    
    private lazy var maxTemp = TemperatureLabel(frame: .zero,
                                                text: "18", font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                textColor: .white,
                                                degreeSize: 6)
    
    private lazy var weatherDescrip: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Возможен небольшой дождь"
        label.backgroundColor = .clear
        label.textColor = .white
        
        return label
    }()
    
    private lazy var sunCloudImage = CustomWeatherIcons(frame: .zero,
                                                   textLabel: "0",
                                                   textColor: .white,
                                                   icon: .sunCloud,
                                                   fontSize: 14)
    private lazy var windIcon = CustomWeatherIcons(frame: .zero,
                                                   textLabel: "3 м/с",
                                                   textColor: .white,
                                                   icon: .wind,
                                                   fontSize: 14)
    private lazy var rainIcon = CustomWeatherIcons(frame: .zero,
                                                   textLabel: "75%",
                                                   textColor: .white,
                                                   icon: .rainDrops, fontSize: 14)
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "17:48, пт 16 апреля"
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private lazy var sunRiseTime: UILabel = {
        let label = UILabel()
        label.text = "05:41"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var sunSetTime: UILabel = {
        let label = UILabel()
        label.text = "19:39"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()

    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "backgroundColor")
        layer.cornerRadius = 10
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lauout
    
    private func layout() {
        
        let elements = [ yellowLine, temperatureLabel, nowTemperature, weatherDescrip, sunSetImage, sunRiseImage, sunCloudImage, windIcon, rainIcon, dateLabel, sunRiseTime, sunSetTime, minTemp, maxTemp]
        elements.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            yellowLine.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            yellowLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33),
            yellowLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31),
            yellowLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70),
            
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 33),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            minTemp.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor),
            minTemp.topAnchor.constraint(equalTo: topAnchor,constant: 33),
            
            maxTemp.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),
            maxTemp.topAnchor.constraint(equalTo: topAnchor, constant: 33),
            
            nowTemperature.centerXAnchor.constraint(equalTo: centerXAnchor),
            nowTemperature.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            
            weatherDescrip.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherDescrip.topAnchor.constraint(equalTo: nowTemperature.bottomAnchor, constant: 5),
            
            sunRiseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            sunRiseImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            sunRiseImage.widthAnchor.constraint(equalToConstant: 17),
            sunRiseImage.heightAnchor.constraint(equalToConstant: 17),
            
            sunSetImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sunSetImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            sunSetImage.heightAnchor.constraint(equalToConstant: 17),
            sunSetImage.widthAnchor.constraint(equalToConstant: 17),
            
            sunCloudImage.leadingAnchor.constraint(equalTo: sunRiseImage.trailingAnchor, constant: 60),
            sunCloudImage.topAnchor.constraint(equalTo: weatherDescrip.bottomAnchor, constant: 15),
            sunCloudImage.widthAnchor.constraint(equalToConstant: 44),
            sunCloudImage.heightAnchor.constraint(equalToConstant: 23),
            
            windIcon.leadingAnchor.constraint(equalTo: sunCloudImage.trailingAnchor, constant: 19),
            windIcon.topAnchor.constraint(equalTo: weatherDescrip.bottomAnchor, constant: 15),
            windIcon.widthAnchor.constraint(equalToConstant: 66),
            windIcon.heightAnchor.constraint(equalToConstant: 23),
            
            rainIcon.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor, constant: 19),
            rainIcon.topAnchor.constraint(equalTo: weatherDescrip.bottomAnchor, constant: 15),
            rainIcon.widthAnchor.constraint(equalToConstant: 50),
            rainIcon.heightAnchor.constraint(equalToConstant: 23),

            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21),
            
            sunRiseTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            sunRiseTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -26),
            
            sunSetTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            sunSetTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -26),
        
        ])
    }
    
}
