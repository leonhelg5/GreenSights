//
//  GSTableHeaderContainer.swift
//  GreenSights
//
//  Created by Leon Helg on 15.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSTableHeaderContainer: UITableViewHeaderFooterView, ReusableView {
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
	}
	
	func configure(view: UIView) {
		self.addSubview(view)
		view.fillSuperview(onlySafeArea: false)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
