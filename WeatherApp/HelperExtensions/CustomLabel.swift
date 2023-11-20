//
//  CustomLabel.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 09.11.2023.
//

import UIKit


final class TemperatureLabel: UIView {
    
    var text: String
    var font: UIFont
    var textColor: UIColor
    var degreeSize: CGFloat
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = text
        label.textColor = textColor
        label.font = font
        
        
        return label
    }()
    
    private lazy var degreeImage: UIView = {
        let degree = UIView()
        degree.translatesAutoresizingMaskIntoConstraints = false
        degree.layer.borderWidth = 0.5
        degree.layer.borderColor = textColor.cgColor
        degree.backgroundColor = .clear
        degree.layer.cornerRadius = 4
        
        return degree
    }()
    
    //MARK: - Initialize
    
    init(frame: CGRect, text: String, font: UIFont, textColor: UIColor, degreeSize: CGFloat) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.degreeSize = degreeSize
        super.init(frame: frame)
         self.translatesAutoresizingMaskIntoConstraints = false
         layout()
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Layout
    
    private func layout() {
        addSubview(label)
        addSubview(degreeImage)
        
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: font.xHeight * 2.5),
            widthAnchor.constraint(equalToConstant: font.xHeight * 2.5),
            
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            
            degreeImage.topAnchor.constraint(equalTo: topAnchor),
            degreeImage.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 3),
            degreeImage.widthAnchor.constraint(equalToConstant: degreeSize),
            degreeImage.heightAnchor.constraint(equalToConstant: degreeSize),
        ])
        
    }

}
