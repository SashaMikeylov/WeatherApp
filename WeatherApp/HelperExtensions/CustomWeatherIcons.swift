//
//  CustomWeatherIcons.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 09.11.2023.
//

import UIKit


final class CustomWeatherIcons: UIView {
    
    
    var textLabel: String
    var textColor: UIColor
    var icon: WeatherIcons
    var sizeFont: CGFloat
    
    enum WeatherIcons: String {
        
        case cloudy = "iconCloudy"
        case cold = "iconCold"
        case hot = "iconHot"
        case moon = "iconMoon"
        case rain = "iconRain"
        case rainDrops = "iconRaindrops"
        case storm = "iconStorm"
        case sun = "iconSun"
        case sunCloud = "iconSunCloud"
        case sunRain = "iconSunRain"
        case whiteCloud = "iconWhiteCloud"
        case wind = "iconWind"
        case fog = "iconFog"
        case snowFlake = "iconSnowFlake"
        
    }
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: icon.rawValue)
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = textLabel
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: sizeFont, weight: .regular)
        
        return label
    }()
    
    //MARK: - Initialize
    
    init(frame: CGRect, textLabel: String, textColor: UIColor, icon: WeatherIcons, fontSize: CGFloat) {
        self.textLabel = textLabel
        self.textColor = textColor
        self.icon = icon
        self.sizeFont = fontSize
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
        
        NSLayoutConstraint.activate([
        
        iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
        iconImage.topAnchor.constraint(equalTo: topAnchor),
        iconImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        label.topAnchor.constraint(equalTo: topAnchor),
        label.bottomAnchor.constraint(equalTo: bottomAnchor),
        label.trailingAnchor.constraint(equalTo: trailingAnchor),
        label.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 5),
        
        ])
    }
    
    
    
}
