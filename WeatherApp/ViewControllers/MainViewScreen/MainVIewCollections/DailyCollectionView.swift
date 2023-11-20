//
//  DailyCollectionView.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 19.11.2023.
//

import UIKit

final class DailyCollectionView: UICollectionView {
    
    private let collectionLayot: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 400, height: 56)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        return layout
    }()
    
    
    //MARK: - Initialize
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayot)
        setUpCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp collection
    
    private func setUpCollection() {
        register(DailyCollectionViewCell.self, forCellWithReuseIdentifier: DailyCollectionViewCell.id)
        dataSource = self
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
    }
    
}


extension DailyCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCollectionViewCell.id, for: indexPath) as? DailyCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    
}
