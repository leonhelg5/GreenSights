//
//  BottomStackView.swift
//  GreenSights
//
//  Created by Leon Helg on 08.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSBottomView: UIView {
	
	let votingStackView = GSVotingStackView()
	let addFriendView = GSInviteAFriendView()
	let starButtonNavItem: GSStarButton = {
		let button = GSStarButton()
		button.tintColor = UIColor.black
		return button
	}()
	
	//MARK: - Init & View Loading
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupConstraints()
	}
	
	//MARK: - Setup
	func setupSubviews() {
		addSubview(votingStackView)
		addSubview(addFriendView)
		addSubview(starButtonNavItem)
	}
	
	func setupConstraints() {
		votingStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		
		addFriendView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: GSSettings.ui.sizes.addFriendButtonSize, height: GSSettings.ui.sizes.addFriendButtonSize)
		addFriendView.translatesAutoresizingMaskIntoConstraints = false
		addFriendView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
		addFriendView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
		
		starButtonNavItem.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 8, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 2, width: 0, height: 0)
		
		layoutIfNeeded()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
