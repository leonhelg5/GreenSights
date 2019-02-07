//
//  GSFavSpotButton.swift
//  GreenSights
//
//  Created by Leon Helg on 10.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

public class GSStarButton: UIButton {
	
	let representingSpotID: String = ""
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		self.setImage(UIImage(named: GSSettings.ui.navBarIcons.starUnselected)?.withRenderingMode(.alwaysTemplate), for: .normal)
		self.setImage(UIImage(named: GSSettings.ui.navBarIcons.starSelected)?.withRenderingMode(.alwaysTemplate), for: .selected)
		self.tintColor = GSSettings.ui.colors.tintColor
	}
	
	override public var intrinsicContentSize: CGSize {
		return CGSize(width: 30, height: 30)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
