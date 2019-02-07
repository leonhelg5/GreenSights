//
//  GSTextFieldView.swift
//  GreenSights
//
//  Created by Leon Helg on 25.12.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSTextFieldView: UIView {
	
	var height: CGFloat = 60
	var cornerRadius: CGFloat = 12
	var textPadding: CGFloat = 18
	
	
	lazy var textField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
		textField.borderStyle = .line
		textField.layer.borderColor = UIColor.white.cgColor
		textField.layer.borderWidth = 0
		
		textField.keyboardType = .default
		textField.textAlignment = .left
		textField.textColor = UIColor.white
		//textField.font = sfpro text regular, 16
		textField.attributedPlaceholder = placeHolder
		
		textField.rightView = GSInfoButton()
		
		return textField
	}()
	
	lazy var placeHolder: NSAttributedString = {
		let placeHolder = NSAttributedString(string: "placeholder",
											 attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.6)])
		//with text: font = sfprotext light italic 14, else 16
		return placeHolder
	}()
	
	var errorLabel: UILabel = {
		let label = UILabel()
		//label.font = UIFont(descriptor: SFpro bold, size: 11)
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupSubviews() {
		self.addSubview(textField)
		self.addSubview(errorLabel)
	}
	
	func setupConstraints() {
		self.textField.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: self.height)
		self.errorLabel.anchor(top: self.textField.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 4, paddingLeading: self.textPadding, paddingBottom: 0, paddingTrailing: self.textPadding, width: 0, height: 0)
	}
	
	func setSelected(to selected: Bool) {
		if selected {
			textField.layer.borderWidth = 1
		} else {
			textField.layer.borderWidth = 0
		}
	}
	
}
