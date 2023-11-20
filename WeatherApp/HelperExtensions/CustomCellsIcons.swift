//
//  CustomCellsIcons.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 16.11.2023.
//

import UIKit


enum WeatherStackType: String {
    case temp = "По ощущениям"
    case wind = "Ветер"
    case ultraviolet = "Видимость"
    case rainfall = "Влажность"
    case cloud = "Облачность"
}

final class CustomCellsIcons: UIView {
    
    
    var titleText: WeatherStackType
    var icon: String = ""
    var value: String

    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        switch titleText {
        case .cloud:
            imageView.image = UIImage(named: "iconCloudy")
        case .rainfall:
            imageView.image = UIImage(named: "iconRain")
        case .temp:
            imageView.image = UIImage(named: "iconHot")
        case .ultraviolet:
            imageView.image = UIImage(named: "iconSun")
        case .wind:
            imageView.image = UIImage(named: "iconWind")
        }
        
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.text = titleText.rawValue
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.text = value
        
        return label
    }()
    
    
    
    //MARK: - Initialize
    
    init(frame: CGRect, titleText: WeatherStackType, value: String) {
        self.titleText = titleText
        self.value = value
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func layout() {
        addSubview(iconImage)
        addSubview(label)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
        
        iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
        iconImage.topAnchor.constraint(equalTo: topAnchor),
        iconImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor),
        label.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15),
        
        valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        valueLabel.topAnchor.constraint(equalTo: topAnchor),
        valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        
        ])
    }
    
    
    
}
