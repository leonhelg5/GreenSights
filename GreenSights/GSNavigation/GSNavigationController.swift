//
//  GSNavigationController.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSNavigationController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavigationBarDefault()
	}
}

extension UINavigationController {
	func setNavigationBarDefault() {
		self.navigationBar.isTranslucent        = false
		self.navigationBar.prefersLargeTitles   = false
		self.navigationBar.barTintColor       = GSSettings.UI.Colors.elementBackgroundColor
		self.navigationBar.backgroundColor    = GSSettings.UI.Colors.elementBackgroundColor
		self.navigationBar.tintColor          = GSSettings.UI.Colors.tintColor
		self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: GSSettings.UI.Fonts.helveticaMedium!.withSize(22)]
	}
}
