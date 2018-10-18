//
//  GS+UILabel.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

//https://medium.com/@nimjea/custom-label-effects-in-swift-4-69ec12ba2178
extension UILabel{
	
	func underline() {
		if let textString = self.text {
			let attributedString = NSMutableAttributedString(string: textString)
			attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
			attributedText = attributedString
		}
	}
}
