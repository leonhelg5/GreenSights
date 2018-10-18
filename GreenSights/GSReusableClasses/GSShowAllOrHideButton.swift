//
//  GSShowAllOrHideButton.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSShowAllOrHideButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setTitle("Show All", for: .normal)
		self.setTitle("Hide", for: .selected)
		self.setTitleColor(GSSettings.UI.Colors.tintColor, for: .normal)
		self.setTitleColor(GSSettings.UI.Colors.tintColor, for: .selected)
		self.titleLabel?.font = GSSettings.UI.Fonts.helveticaRegular?.withSize(18)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
