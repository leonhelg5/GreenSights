//
//  GSAltDetailTableView.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit
import Foundation

protocol altDetailsTableViewDelegate: class {
	func needsToUpdateDetailsTableViewHeight()
}

class GSAltDetailTableView: UIView {
	
	weak var delegate: altDetailsTableViewDelegate?
	let titles = ["Sitzplätze", "Regensicher", "Lautstärkentoleranz", "Polizeipräsenz", "Anwohner", "Passanten", "Erreichbarkeit"]
	let values = ["13", "Ja", "Keine", "Keine", "Mittel", "Wenig", "Gut"]
	
	let headerId = "headerId"
	let footerId = "footerId"
	
	//Static values:
	let rowHeight: CGFloat = 44
	let headerHeight: CGFloat = 30//57
	let footerHeight: CGFloat = 30
	let numberOfRowsWhenUnexpanded: Int = 2

	//Variables
	var isExpanded: Bool = false
	var currentNumberOfRows: Int = 2
	
	lazy var headerTap: UITapGestureRecognizer = {
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleHeaderTap(sender:)))
		tap.delegate	= self
		return tap
	}()
	

	lazy var tableView: UITableView = {
		let tableview = UITableView(frame: .zero, style: .grouped)
		tableview.dataSource = self
		tableview.delegate = self
		tableview.showsHorizontalScrollIndicator = false
		tableview.isScrollEnabled = false
		tableview.isUserInteractionEnabled = true
		tableview.rowHeight = rowHeight
		tableview.sectionHeaderHeight = headerHeight
//		tableview.estimatedSectionHeaderHeight = headerHeight
		tableview.sectionFooterHeight = footerHeight
		tableview.register(GSAltDetailTableViewCell.self, forCellReuseIdentifier: GSAltDetailTableViewCell.reuseIdentifier)
		tableview.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerId)
		tableview.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: footerId)
		return tableview
	}()

	
	//MARK: -
	//MARK: - Init & View Loading
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupContstraints()
	}
	
	//MARK: - Setup
	func setupSubviews() {
		addSubview(tableView)
	}
	
	func setupContstraints() {
		tableView.fillSuperview(onlySafeArea: false)
	}
	
	/**
	The animation is made by modifying the heightConstraint of this class.
	In Case of insert, insert is made before changing the constraint
	In Case of delete, delete is made after the height is back to small. Call is made after the delegate method is finished (still in delegate)
	*/
	func handleShowAll() {
		if isExpanded {
			currentNumberOfRows = titles.count
			insertRows()
		} else {
			currentNumberOfRows = numberOfRowsWhenUnexpanded
		}
		delegate?.needsToUpdateDetailsTableViewHeight()
	}
	
	func insertRows() {
		let indexPaths = createIndexPath()
		tableView.beginUpdates()
		tableView.insertRows(at: indexPaths, with: .fade)
		tableView.endUpdates()
	}
	
	func deleteRows() {
		let indexPaths = createIndexPath()
		tableView.beginUpdates()
		tableView.deleteRows(at: indexPaths, with: .fade)
		tableView.endUpdates()
	}
	
	func createIndexPath() -> [IndexPath] {
		var indexPaths = [IndexPath]()
		for row in numberOfRowsWhenUnexpanded..<titles.count {
			let indexPath = IndexPath(row: row, section: 0)
			indexPaths.append(indexPath)
		}
		return indexPaths
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSAltDetailTableView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("row pressed")
		tableView.deselectRow(at: indexPath, animated: false)
	}
}

extension GSAltDetailTableView: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isExpanded {
			return titles.count
		}
		return numberOfRowsWhenUnexpanded
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: GSAltDetailTableViewCell.reuseIdentifier, for: indexPath) as! GSAltDetailTableViewCell
		cell.textLabel?.text = titles[indexPath.row]
		cell.detailTextLabel?.text = values[indexPath.row]
		return cell
	}

	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
		header?.textLabel?.text = "Details \u{23f5}"
//		header.detailTextLabel?.text = "Expand all"
//		header.detailTextLabel?.underline()
		header?.tag = section
		header?.addGestureRecognizer(headerTap)
		return header
	}
	
	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		return "Alles"
	}
}

extension GSAltDetailTableView: UIGestureRecognizerDelegate {
	@objc func handleHeaderTap(sender: UITapGestureRecognizer) {
		print("header pressed")
		isExpanded.toggle()
		handleShowAll()
	}
}
