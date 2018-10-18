//
//  AddFriendView.swift
//  GreenSights
//
//  Created by Leon Helg on 08.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSInviteAFriendView: UIView {
	var mySize: CGFloat = GSSettings.UI.Sizes.addFriendButtonSize
	
	let addFriendButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .clear
		button.setImage(UIImage(named: GSSettings.UI.otherIcons.addFriend)?.withRenderingMode(.alwaysOriginal), for: .normal)
		button.layer.shadowColor = UIColor.black.cgColor
		button.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
		button.layer.masksToBounds = false
		button.layer.shadowRadius = 1.5
		button.layer.shadowOpacity = 0.4
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
	}
	
	func setupSubviews() {
		self.addSubview(addFriendButton)
		
		addFriendButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: mySize, height: mySize)
		addFriendButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		addFriendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		addFriendButton.layer.cornerRadius = mySize/2
		
		addFriendButton.imageView?.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: mySize, height: mySize)
		addFriendButton.imageView?.layer.cornerRadius = mySize/2
		
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: mySize, height: mySize)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

