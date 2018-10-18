//
//  GSTableHeaderView.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

//@objc protocol tableHeaderViewDelegate {
//	@objc func expandTableView(shouldExpand: Bool)
//}

class GSTableHeaderView: UIView {
//	var delegateHV: tableHeaderViewDelegate?
	
	var label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let header = UITableViewHeaderFooterView()
		header.textLabel?.text = "ss"
		self.backgroundColor = header.backgroundColor
		addSubview(header)
		header.fillSuperview(onlySafeArea: false)
		//label = header.textLabel ?? UILabel()
//		label.sizeToFit()
//		label.text = "HUHUHU"
//		addSubview(label)
//		bringSubviewToFront(label)
//		label.textColor = .black
//		label.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 25, paddingBottom: 3, paddingTrailing: 0, width: 100, height: 30)
	}
	
	
	
//	func configure() {
//		setupSubviews()
//		setupConstraints()
//	}
//
//	func setupSubviews() {
//		guard let detailTextLabel = detailTextLabel, let textLabel = textLabel else { return }
//		contentView.addSubview(detailTextLabel)
//	}
//
//	func setupConstraints() {
//		guard let detailTextLabel = detailTextLabel, let textLabel = textLabel else { return }
//		detailTextLabel.anchor(top: nil, leading: nil, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)
//		detailTextLabel.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true
//	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
