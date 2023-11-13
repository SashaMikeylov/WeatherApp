//
//  CustomSegmentController.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 05.11.2023.
//

import UIKit

protocol SettingsProtocol: AnyObject {
    func segmentValue(value: String)
}

final class CustomSegmentView: UIView {

    weak var customSegmentDelegate: SettingsProtocol?
    
    var segmentTitle: String
    var segmentPropertyRight: String
    var segmentPropertyLeft: String
    var selected: Int
    
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [segmentPropertyLeft,segmentPropertyRight])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = selected
        segmentControl.backgroundColor = UIColor(named: "segmentColor")
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white ], for: .selected)
        segmentControl.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        
        return segmentControl
    }()
    
    private lazy var segmentViewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = segmentTitle
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .gray
        
        return label
    }()
    
    //MARK: - Initialize
    
    init(segmentTitle: String, segmentPropertyLeft: String, segmentPropertyRight: String, selected: Int ) {
        self.segmentTitle = segmentTitle
        self.segmentPropertyLeft = segmentPropertyLeft
        self.segmentPropertyRight = segmentPropertyRight
        self.selected = selected
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.layout()
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Layout
    
    private func layout() {
        addSubview(segmentControl)
        addSubview(segmentViewTitle)
        
        NSLayoutConstraint.activate([
            segmentControl.heightAnchor.constraint(equalToConstant: 40),
            segmentControl.widthAnchor.constraint(equalToConstant: 80),
            segmentControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            segmentViewTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentViewTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            
            heightAnchor.constraint(equalToConstant:  50),
            widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc private func segmentAction() {
        let value = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)!
        customSegmentDelegate?.segmentValue(value: value)
    }
}

    

