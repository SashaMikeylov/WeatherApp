//
//  miniWeatherInfoCell.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 12.11.2023.
//

import UIKit

final class MiniWeatherInfoCell: UICollectionViewCell {
    
    static let id = "MiniWeatherInfoCell"
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:00"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.backgroundColor = .clear
        
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "iconSun")
        
        return icon
    }()
    
    private lazy var temperatureLabel = TemperatureLabel(frame: .zero,
                                                         text: "16",
                                                         font: UIFont.systemFont(ofSize: 16, weight: .regular),
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
    
    
    //MARK: - SetUpCell
    
    private func setUpCell() {
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.blue.cgColor
        layer.cornerRadius = 22
    }
    
    //MARK: - Layout
    
    private func layout() {
        let elements = [timeLabel, icon, temperatureLabel]
        elements.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
        
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            icon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 2),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
        
        
    }
}


