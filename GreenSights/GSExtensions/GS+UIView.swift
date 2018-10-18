//
//  GS+UIView.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit
extension UIView {
	func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeading: CGFloat, paddingBottom: CGFloat, paddingTrailing: CGFloat, width: CGFloat, height: CGFloat) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}
		
		if let leading = leading {
			leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
		}
		
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
		}
		
		if let trailing = trailing {
			trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
		}
		
		if width != 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		
		if height != 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}
	
	func fillSuperview(onlySafeArea: Bool) {
		translatesAutoresizingMaskIntoConstraints = false
		guard let superview = superview else { print("Error with filling superview"); return}
		if !onlySafeArea {
			topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
			leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
			bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
			trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
		} else {
			topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
			leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
			bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
			trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
		}
	}
	
	func fixHeightAndWidth(width: CGFloat, height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		if width != 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		
		if height != 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}
	
	
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		layer.mask = mask
	}
	
}


