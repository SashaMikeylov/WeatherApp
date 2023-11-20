//
//  DailyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 19.11.2023.
//

import UIKit

final class DailyCollectionViewCell: UICollectionViewCell {
    
    static let id = "DailyCollectionViewCell"
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "17/04"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.backgroundColor = .clear
        
        return label
    }()
    
    private lazy var weatherIcon = CustomWeatherIcons(frame: .zero,
                                                      textLabel: "57%",
                                                      textColor: .blue,
                                                      icon: .rain,
                                                      fontSize: 12)
    private lazy var weatherDescrip: UILabel = {
        let label = UILabel()
        label.text = "Местами дождь"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private lazy var minTemperature = TemperatureLabel(frame: .zero,
                                                       text: "4",
                                                       font: UIFont.systemFont(ofSize: 18, weight: .regular),
                                                       textColor: .black,
                                                       degreeSize: 5)
    
    private lazy var temperatureStick: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.backgroundColor = .clear
        
        return  label
    }()
    
    private lazy var maxTemperature = TemperatureLabel(frame: .zero,
                                                       text: "11",
                                                       font: UIFont.systemFont(ofSize: 18, weight: .regular),
                                                       textColor: .black,
                                                       degreeSize: 5)
    
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp cell
    
    private func setUpCell() {
        backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        layer.cornerRadius = 5
        
    }
    
    //MARK: - Layout
    
    private func layout() {
        let elements = [dateLabel, weatherIcon, weatherDescrip, minTemperature, temperatureStick, maxTemperature]
        elements.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            weatherIcon.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            weatherIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            weatherDescrip.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor, constant: 5),
            weatherDescrip.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            maxTemperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            maxTemperature.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            temperatureStick.trailingAnchor.constraint(equalTo: maxTemperature.leadingAnchor, constant: -4),
            temperatureStick.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            minTemperature.trailingAnchor.constraint(equalTo: temperatureStick.leadingAnchor, constant: 4),
            minTemperature.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        ])
    }
    
    
}
