//
//  GSListEventCollectionViewCell.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class test: UITableViewCell, ReusableView {
	
	lazy var dotsButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: GSSettings.UI.otherIcons.dotsHorizontal)?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.setImage(UIImage(named: GSSettings.UI.otherIcons.dotsVertical)?.withRenderingMode(.alwaysTemplate), for: .selected)
		button.addTarget(self, action: #selector(seeMore), for: .touchUpInside)
		button.fixHeightAndWidth(width: 28, height: 28)
		button.tintColor = UIColor.gray//GSSettings.UI.Colors.tintColor
		return button
	}()
	
	let thumbnailImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = true
		imageview.image = UIImage(named: "testbild")
		return imageview
	}()
	
	let blackView: UIImageView = {
		let imageview = UIImageView()
		imageview.backgroundColor = UIColor.black.withAlphaComponent(0.35)
		return imageview
	}()
	
	let titleLabel : UILabel = {
		let label = UILabel()
		label.text = "Titel Titel"
		label.font = GSSettings.UI.Fonts.helveticaMedium?.withSize(22)
		label.textColor = UIColor.white
		return label
	}()
	
	lazy var starButton: GSStarButton = {
		let button = GSStarButton()
		button.tintColor = UIColor.white//GSSettings.UI.Colors.nightOrange
		button.addTarget(self, action: #selector(handleStarButton), for: .touchUpInside)
		return button
	}()
	
	lazy var infoButton: GSInfoButton = {
		let button = GSInfoButton()
		button.tintColor = UIColor.white//GSSettings.UI.Colors.nightOrange
		button.addTarget(self, action: #selector(handleInfoButton), for: .touchUpInside)
		return button
	}()
	
	let addFriendView = GSInviteAFriendView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.clipsToBounds = false
		self.selectionStyle = .none
		setupSubviews()
		setupConstraints()
		perform(#selector(printBounds), with: nil, afterDelay: 5)
	}
	
	func setupSubviews() {
		self.addSubview(dotsButton)
		self.addSubview(thumbnailImageView)
		thumbnailImageView.addSubview(blackView)
		blackView.addSubview(titleLabel)
		//        blackView.addSubview(descriptionLabel)
		blackView.addSubview(starButton)
		blackView.addSubview(infoButton)
		self.addSubview(addFriendView)
		
		blackView.isHidden = true
		//        descriptionLabel.isHidden = true
	}
	
	func setupConstraints() {
		dotsButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)
		
		
		thumbnailImageView.anchor(top: dotsButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 4, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)
		thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 9/16).isActive = true
		blackView.fillSuperview(onlySafeArea: true)
		
		titleLabel.anchor(top: thumbnailImageView.topAnchor, leading: thumbnailImageView.leadingAnchor, bottom: nil, trailing: starButton.leadingAnchor, paddingTop: 8, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 8, width: 0, height: 20)
		
		infoButton.anchor(top: thumbnailImageView.topAnchor, leading: nil, bottom: nil, trailing: thumbnailImageView.trailingAnchor, paddingTop: 8, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 8, width: 30, height: 30)
		starButton.anchor(top: thumbnailImageView.topAnchor, leading: nil, bottom: nil, trailing: infoButton.leadingAnchor, paddingTop: 8, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 4, width: 30, height: 30)
		
		addFriendView.anchor(top: thumbnailImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: -GSSettings.UI.Sizes.addFriendButtonSize/2 + 10, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: GSSettings.UI.Sizes.addFriendButtonSize, height: GSSettings.UI.Sizes.addFriendButtonSize)
		addFriendView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
	}
	
	@objc func seeMore() {
		dotsButton.isSelected.toggle()
		if dotsButton.isSelected {
			blackView.isHidden = false
		} else {
			blackView.isHidden = false
		}
		layoutIfNeeded()
	}
	
	@objc func handleStarButton() {
		starButton.isSelected.toggle()
		if starButton.isSelected {
			starButton.tintColor = GSSettings.UI.Colors.nightOrange
		} else {
			starButton.tintColor = UIColor.white
		}
	}
	
	@objc func handleInfoButton() {
		infoButton.isSelected.toggle()
	}
	
	@objc func printBounds() {
		print("::::")
		print(thumbnailImageView.bounds)
		print(infoButton.bounds)
		print(starButton.bounds)
		print("_____")
		print(thumbnailImageView.frame)
		print(infoButton.frame)
		print(starButton.frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

