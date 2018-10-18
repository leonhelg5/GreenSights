////
////  GSDetailTableView.swift
////  GreenSights
////
////  Created by Leon Helg on 09.10.18.
////  Copyright © 2018 Leon Helg. All rights reserved.
////
//
//import UIKit
//
//protocol detailsTableViewDelegate: class {
//	func setdetailsTVHeight(height: CGFloat)
//}
//
//class GSDetailTableView: UIView {
//	weak var delegate: detailsTableViewDelegate?
//	var titles = ["Sitzplätze", "Regensicher", "Lautstärkentoleranz", "Polizeipräsenz", "Anwohner", "Passanten", "Erreichbarkeit"]
//	var values = ["13", "Ja", "Keine", "Keine", "Mittel", "Wenig", "Gut"]
//
//	//Constraint Surgery:
//	let paddingBetweenLabelAndTV: CGFloat = 4
//	let numberOfRowsWhenUnexpanded: Int = 2
//	var heightOfTableView = NSLayoutConstraint()
//	var currentNumberOfRows: Int = 2
//
//	let detailsLabel: UILabel = {
//		let label       = UILabel()
//		label.font      = GSSettings.UI.Fonts.helveticaRegular?.withSize(20)
//		label.text      = "Details:"
//		label.textColor = GSSettings.UI.Colors.regularTextColor
//		label.numberOfLines = 1
//		return label
//	}()
//
//	let showAllOrHideButton = GSShowAllOrHideButton()
//
//	lazy var tableView: UITableView = {
//		let tableview = UITableView()
//		tableview.dataSource = self
//		tableview.delegate = self
//		tableview.separatorInset = UIEdgeInsets.zero
//		tableview.backgroundColor = GSSettings.UI.Colors.backgroundWhite
//		tableview.rowHeight = 45
//		tableview.showsHorizontalScrollIndicator = false
//		tableview.register(GSDetailTableViewCell.self, forCellReuseIdentifier: GSDetailTableViewCell.reuseIdentifier)
//		return tableview
//	}()
//
//
//	//MARK: -
//	//MARK: - Init & View Loading
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		self.clipsToBounds = true
//		setupSubviews()
//		setupContstraints()
//	}
//
//	//MARK: - Setup
//	func setupSubviews() {
//		addSubview(detailsLabel)
//		addSubview(showAllOrHideButton)
//		addSubview(tableView)
//		detailsLabel.underline()
//		showAllOrHideButton.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
//		heightOfTableView = tableView.heightAnchor.constraint(equalToConstant: CGFloat(numberOfRowsWhenUnexpanded) * tableView.rowHeight)
//		heightOfTableView.isActive = true
//	}
//
//	func setupContstraints() {
//		detailsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
//		showAllOrHideButton.anchor(top: nil, leading: nil, bottom: detailsLabel.bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
//		showAllOrHideButton.heightAnchor.constraint(equalTo: detailsLabel.heightAnchor).isActive = true
//
//		tableView.anchor(top: detailsLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: paddingBetweenLabelAndTV, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
//	}
//
//	/**
//	The animation is made by modifying the heightConstraint of this class.
//	In Case of insert, insert is made before changing the constraint
//	In Case of delete, delete is made after the height is back to small. Call is made after the delegate method is finished (still in delegate)
//	*/
//	@objc func handleShowAll() {
//		showAllOrHideButton.isSelected.toggle()
//		if showAllOrHideButton.isSelected {
//			currentNumberOfRows = titles.count
//			insertRows()
//		} else {
//			currentNumberOfRows = numberOfRowsWhenUnexpanded
//		}
//		delegate?.setdetailsTVHeight(height: calculateHeight())
//	}
//
//	func insertRows() {
//		let indexPaths = createIndexPath()
//		heightOfTableView.constant = CGFloat(titles.count) * tableView.rowHeight
//		tableView.beginUpdates()
//		tableView.insertRows(at: indexPaths, with: .fade)
//		tableView.endUpdates()
//	}
//
//	func deleteRows() {
//		let indexPaths = createIndexPath()
//		heightOfTableView.constant = CGFloat(numberOfRowsWhenUnexpanded) * tableView.rowHeight
//		tableView.beginUpdates()
//		tableView.deleteRows(at: indexPaths, with: .fade)
//		tableView.endUpdates()
//	}
//
//	//TODO: create variable for indexpath instead of function
//	func createIndexPath() -> [IndexPath]{
//		var indexPaths = [IndexPath]()
//		for row in numberOfRowsWhenUnexpanded..<titles.count {
//			let indexPath = IndexPath(row: row, section: 0)
//			indexPaths.append(indexPath)
//		}
//		return indexPaths
//	}
//
//	func calculateHeight() -> CGFloat {
//		layoutIfNeeded()
//		var height: CGFloat = 0
//		height += detailsLabel.bounds.height
//		height += paddingBetweenLabelAndTV
//		height += CGFloat(currentNumberOfRows) * (tableView.rowHeight + 0.5)
//		return height
//	}
//
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//}
//
//extension GSDetailTableView: UITableViewDelegate {
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		tableView.deselectRow(at: indexPath, animated: false)
//	}
//}
//
//extension GSDetailTableView: UITableViewDataSource {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		if showAllOrHideButton.isSelected {
//			return titles.count
//		}
//		return numberOfRowsWhenUnexpanded
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		//TODO: switch index path
//		let cell = self.tableView.dequeueReusableCell(withIdentifier: GSDetailTableViewCell.reuseIdentifier, for: indexPath) as! GSDetailTableViewCell
//
//		//config
//		cell.titleLabel.text = titles[indexPath.row]
//		cell.valueLabel.text = values[indexPath.row]
//		return cell
//	}
//}
//
//
//
