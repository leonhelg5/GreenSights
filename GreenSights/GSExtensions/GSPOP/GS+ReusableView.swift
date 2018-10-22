//
//  GS+ReusableView.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
