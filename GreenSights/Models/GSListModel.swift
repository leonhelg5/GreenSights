//
//  GSListModel.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSListModel {
	static func fillViews() -> [UIView]{
		let greenView = UIView()
		greenView.backgroundColor = UIColor.white
		let blueView = UIView()
		blueView.backgroundColor = UIColor.blue
		let redView = UIView()
		redView.backgroundColor = UIColor.white
		
		let views = [greenView, blueView, redView]
		
		blueView.isHidden = true
		redView.isHidden = true
		greenView.isHidden = false
		
		return views
	}
}
