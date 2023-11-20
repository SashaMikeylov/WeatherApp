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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.estimatedItemSize = CGSize(width: 42, height: 85)
        
        
        return layout
    }()
    
    //MARK: - Initialize
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        setUpCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp collection
    
    private func setUpCollection() {
        register(MiniWeatherInfoCell.self, forCellWithReuseIdentifier: MiniWeatherInfoCell.id)
        dataSource = self
        delegate = self
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
}

//MARK: - Extensions

extension MiniWeatherInfoCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniWeatherInfoCell.id, for: indexPath) as? MiniWeatherInfoCell else {return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
