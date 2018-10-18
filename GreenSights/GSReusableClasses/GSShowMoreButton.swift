//
//  GSShowMoreButton.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSShowMoreButton: UIButton {
	
    let representingSpotID: String = ""
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setImage(UIImage(named: GSSettings.ui.otherIcons.dotsHorizontal)?.withRenderingMode(.alwaysTemplate), for: .normal)
		self.setImage(UIImage(named: GSSettings.ui.otherIcons.dotsVertical)?.withRenderingMode(.alwaysTemplate), for: .selected)
		self.tintColor = GSSettings.ui.colors.tintColor
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 30, height: 30)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
