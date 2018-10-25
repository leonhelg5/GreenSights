//
//  GSPostOrientationButton.swift
//  GreenSights
//
//  Created by Leon Helg on 25.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPostOrientationButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(iconName: String) {
        self.init()
        self.setImage(UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 45, height: 45)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
