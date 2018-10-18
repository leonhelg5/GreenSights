//
//  VotingStackView.swift
//  GreenSights
//
//  Created by Leon Helg on 08.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSVotingStackView: UIStackView {
	
	let arrowUpButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .clear
		button.tintColor = GSSettings.ui.colors.tintColor
		button.imageView?.contentMode = .scaleAspectFit
		button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
		button.clipsToBounds = true
		return button
	}()
	
	let arrowDownButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .clear
		button.tintColor = GSSettings.ui.colors.tintColor
		button.imageView?.contentMode = .scaleAspectFit
		button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
		button.clipsToBounds = true
		return button
	}()
	
	let percentageLabel: UILabel = {
		let label = UILabel()
		label.text = "80%"
		label.textColor = GSSettings.ui.colors.regularTextColor
		label.font = GSSettings.ui.fonts.helveticaRegular?.withSize(18)
		label.clipsToBounds = false
		return label
	}()
	
	//MARK: - Init & View Loading
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupImages()
		setupSubviews()
	}
	
	//MARK: - Setup
	func setupImages() {
		let upImage = UIImage(named: "arrow_up_border")
		let downImage = UIImage(named: "arrow_down_border")
		
		arrowUpButton.setImage(upImage, for: .normal)
		arrowDownButton.setImage(downImage, for: .normal)
	}
	
	func setupSubviews() {
		addSubview(arrowUpButton)
		addSubview(percentageLabel)
		addSubview(arrowDownButton)
		
		arrowUpButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 30, height: 0)
		percentageLabel.anchor(top: topAnchor, leading: arrowUpButton.trailingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 2, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		arrowDownButton.anchor(top: topAnchor, leading: percentageLabel.trailingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 30, height: 0)
		
		layoutIfNeeded()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
