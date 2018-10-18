//
//  GSFavSpotButton.swift
//  GreenSights
//
//  Created by Leon Helg on 10.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSStarButton: UIButton {
    
	let mySpotId: String = ""
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setImage(UIImage(named: GSSettings.UI.NavBarIcons.starUnselected)?.withRenderingMode(.alwaysTemplate), for: .normal)
		self.setImage(UIImage(named: GSSettings.UI.NavBarIcons.starSelected)?.withRenderingMode(.alwaysTemplate), for: .selected)
		self.tintColor = GSSettings.UI.Colors.tintColor
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 30, height: 30)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
