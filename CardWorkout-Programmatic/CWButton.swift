//
//  CWButton.swift
//  CardWorkout-Programmatic
//
//  Created by Shriram Ghadge on 09/02/23.
//

import UIKit

class CWButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    init(color: UIColor, title: String, iconName: String) {
        super.init(frame: .zero)
        
        configuration = .tinted()
        
        configuration?.title = title
        configuration?.baseForegroundColor = color
        configuration?.baseBackgroundColor = color
        configuration?.cornerStyle = .medium
        
        configuration?.image = UIImage(systemName: iconName)
        configuration?.imagePadding = 5
        configuration?.imagePlacement = .leading

        translatesAutoresizingMaskIntoConstraints = false // set Auto-layout
        
//        self.backgroundColor = backgroundColor
//        setTitle(title, for: .normal)
//        configure()
        
    }
    
    func configure(){
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false // set Auto-layout
    }
}
