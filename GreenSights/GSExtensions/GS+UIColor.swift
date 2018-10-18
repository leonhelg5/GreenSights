//
//  GS+UIColor.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit
extension UIColor {
	static func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
}
