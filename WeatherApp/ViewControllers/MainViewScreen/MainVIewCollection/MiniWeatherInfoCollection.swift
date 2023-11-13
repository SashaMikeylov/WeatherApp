//
//  MiniWeatherInfoCollection.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 12.11.2023.
//

import UIKit

final class MiniWeatherInfoCollection: UICollectionView {
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return layout
    }()
    
    

}
