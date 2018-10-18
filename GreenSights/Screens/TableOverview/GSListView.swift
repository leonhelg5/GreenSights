//
//  GSListView.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

protocol listViewDelegate: Any {
	func changeViewTo(newView: UIView, oldView: UIView)
	func pushTo()
}

class GSListView: UIView {
	var delegate: listViewDelegate?
	var listSegmentController = GSSegmentController()
	
	lazy var tableView: UITableView = {
		let tableview = UITableView()
		tableview.backgroundColor = UIColor.white
		tableview.separatorColor = .clear
		tableview.estimatedRowHeight = 267
		tableview.rowHeight = UITableView.automaticDimension
		tableview.dataSource = self
		tableview.delegate = self
		tableview.register(GSOverviewTableViewCell.self, forCellReuseIdentifier: GSOverviewTableViewCell.reuseIdentifier)
		return tableview
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setViews()
		setupSubviews()
		setupContstraints()
	}
	
	func setViews() {
		let array = ["All", "Popular", "Favs"]
		listSegmentController = GSSegmentController(segments: array)
		listSegmentController.delegate = self
	}
	
	func setupSubviews() {
		self.addSubview(listSegmentController)
		self.addSubview(tableView)
	}
	
	func setupContstraints() {
		listSegmentController.anchor(top: self.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 10, paddingLeading: 10, paddingBottom: 0, paddingTrailing: 10, width: 0, height: 50)
		tableView.anchor(top: listSegmentController.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 10, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		delegate?.pushTo()
	}
}

extension GSListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: GSOverviewTableViewCell.reuseIdentifier, for: indexPath) as! GSOverviewTableViewCell
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

extension GSListView: segmentDelegate {
	func segmentSelected(previous: Int, future: Int) {
		//delegate?.changeViewTo(newView: views[future], oldView: views[previous])
	}
}
