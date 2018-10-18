//
//  GSDetailTVCell.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSAltDetailTableViewCell: UITableViewCell, ReusableView {
	
	//MARK: - Init & View Loading
	override init(style: UITableViewCell.CellStyle = .value1, reuseIdentifier: String?) {
		super.init(style: .value1, reuseIdentifier: reuseIdentifier)
		self.accessoryType = .disclosureIndicator
//		self.textLabel?.font = GSSettings.UI.Fonts.helveticaRegular?.withSize(20)
//		self.detailTextLabel?.font = GSSettings.UI.Fonts.helveticaRegularItalic?.withSize(16)
        layoutIfNeeded()
	}
	
	//MARK: - Do not change Methods
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
