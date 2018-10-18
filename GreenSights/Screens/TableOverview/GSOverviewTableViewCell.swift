//
//  GSListEventCollectionViewCell.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSOverviewTableViewCell: UITableViewCell, ReusableView {
	
	lazy var dotsButton: GSShowMoreButton = {
		let button = GSShowMoreButton()
		button.addTarget(self, action: #selector(seeMore), for: .touchUpInside)
		button.tintColor = UIColor.gray//GSSettings.UI.Colors.tintColor
		return button
	}()
	
	let thumbnailImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = true
		imageview.image = UIImage(named: "testbild")
		imageview.isUserInteractionEnabled = true
		return imageview
	}()
	
	let blackView: UIImageView = {
		let imageview = UIImageView()
		imageview.backgroundColor = UIColor.black.withAlphaComponent(0.35)
		imageview.isUserInteractionEnabled = true
		return imageview
	}()
	
	let titleLabel : UILabel = {
		let label = UILabel()
		label.text = "Brainded"
		label.font = GSSettings.UI.Fonts.helveticaMedium?.withSize(22)
		label.textColor = UIColor.white
		return label
	}()
	
	let descriptionLabel : UILabel = {
		let label = UILabel()
		label.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
		label.font = GSSettings.UI.Fonts.helveticaRegular?.withSize(18)
		label.textColor = UIColor.white
		label.numberOfLines = 0
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
	var viewsToHide = [UIView]()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.selectionStyle = .none
		setupSubviews()
		setupConstraints()
	}
	
	func setupSubviews() {
		self.contentView.addSubview(dotsButton)
		self.contentView.addSubview(thumbnailImageView)
		thumbnailImageView.addSubview(blackView)
		blackView.addSubview(titleLabel)
		blackView.addSubview(descriptionLabel)
		blackView.addSubview(starButton)
		blackView.addSubview(infoButton)
		self.contentView.addSubview(addFriendView)
		
		blackView.isHidden = true
		descriptionLabel.isHidden = true
	}
	
	func setupConstraints() {
		let paddingBottomTop: CGFloat = 10
		let friendButtonPadding = -GSSettings.UI.Sizes.addFriendButtonSize/2 + 10
		
		dotsButton.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: paddingBottomTop, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)
		
		thumbnailImageView.anchor(top: dotsButton.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 4, paddingLeading: 16, paddingBottom: paddingBottomTop, paddingTrailing: 16, width: 0, height: 0)
		thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 9/16).isActive = true
		blackView.fillSuperview(onlySafeArea: true)
		
		titleLabel.anchor(top: thumbnailImageView.topAnchor, leading: thumbnailImageView.leadingAnchor, bottom: nil, trailing: starButton.leadingAnchor, paddingTop: 12, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 8, width: 0, height: 0)
		
		infoButton.anchor(top: nil, leading: nil, bottom: nil, trailing: thumbnailImageView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 8, width: 0, height: 0)
		infoButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 2).isActive = true
		
		starButton.anchor(top: nil, leading: nil, bottom: nil, trailing: infoButton.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 4, width: 0, height: 0)
		starButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 2).isActive = true
		
		descriptionLabel.anchor(top: infoButton.bottomAnchor, leading: thumbnailImageView.leadingAnchor, bottom: thumbnailImageView.bottomAnchor, trailing: thumbnailImageView.trailingAnchor, paddingTop: 0, paddingLeading: 8, paddingBottom: 8, paddingTrailing: 8, width: 0, height: 0)
		
		addFriendView.anchor(top: thumbnailImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: friendButtonPadding, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		addFriendView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true

	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		//contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
		thumbnailImageView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: GSSettings.UI.Sizes.cornerRadius)
		
	}
	
	@objc func seeMore() {
		dotsButton.isSelected.toggle()
		if dotsButton.isSelected {
			blackView.isHidden = false
		} else {
			blackView.isHidden = true
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
		if infoButton.isSelected {
			flip(toRight: true, flippingView: thumbnailImageView, viewsToHide: [], viewsToShow: [descriptionLabel])
		} else {
			flip(toRight: false, flippingView: thumbnailImageView, viewsToHide: [descriptionLabel], viewsToShow: [])
		}
	}
	
	@objc func flip(toRight: Bool, flippingView: UIView, viewsToHide: [UIView], viewsToShow: [UIView]) {
		var transitionOptions = UIView.AnimationOptions()
		if toRight {
			transitionOptions = [.transitionFlipFromRight, .showHideTransitionViews]
		} else {
			transitionOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
		}
		
		UIView.transition(with: flippingView, duration: 0.3, options: transitionOptions, animations: {
			for view in viewsToHide {
				view.isHidden = true
			}
			for view in viewsToShow {
				view.isHidden = false
			}
		}) { (result: Bool) in
			//TODO
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
