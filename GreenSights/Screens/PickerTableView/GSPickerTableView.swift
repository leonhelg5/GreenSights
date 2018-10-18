//
//  GSPickerTableView.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPickerTableView: UIView {
	var data = [String]()
	
	lazy var tableView: UITableView = {
		let tableview = UITableView()
		tableview.dataSource = self
		tableview.delegate = self
		//tableview.separatorInset = UIEdgeInsets.zero
		tableview.backgroundColor = GSSettings.UI.Colors.backgroundWhite
		tableview.rowHeight = 45
		//tableview.register(GSDetailTableViewCell.self, forCellReuseIdentifier: GSDetailTableViewCell.reuseIdentifier)
		return tableview
	}()
	
	//MARK: -
	//MARK: - Init & View Loading
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.clipsToBounds = true
		setupSubviews()
		setupContstraints()
	}
	
	//MARK: - Setup
	func setupSubviews() {
		addSubview(tableView)
	}
	
	func setupContstraints() {
		tableView.fillSuperview(onlySafeArea: true)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSPickerTableView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
	}
}

extension GSPickerTableView: UITableViewDataSource {
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: GSAltDetailTableViewCell.reuseIdentifier, for: indexPath) as! GSAltDetailTableViewCell
		return cell
	}
}
