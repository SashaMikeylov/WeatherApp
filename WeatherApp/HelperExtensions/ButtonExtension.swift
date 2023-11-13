//
//  ButtonExtension.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 01.11.2023.
//

import UIKit

extension UIButton {
    
    //MARK: Func for button animation
    
     func addButtonAnimation() {
        
        addTarget(self, action: #selector(buttonPressed), for: [
            .touchDragInside,
            .touchDown,
        ])
        
        addTarget(self, action: #selector(buttonAnPressed), for: [
            .touchCancel,
            .touchUpOutside,
            .touchDragExit,
            .touchDragOutside,
            .touchUpInside
        ])
        
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.1, animations: { self.alpha = 0.5 })
    }
    
    @objc private func buttonAnPressed() {
        UIView.animate(withDuration: 0.1, animations: { self.alpha = 1 })
    }
    
}
