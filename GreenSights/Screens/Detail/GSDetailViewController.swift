//
//  GSDetailViewController.swift
//  GreenSights
//
//  Created by Leon Helg on 09.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit
import MapKit

class GSDetailViewController: GSBaseViewController {
	let containerScrollView = GSDetailScrollView()
	
	let provLocation = CLLocationCoordinate2D(latitude: 47.553217, longitude: 8.891721)
	
	lazy var starButtonNavItem: GSStarButton = {
		let button = GSStarButton()
		button.addTarget(self, action: #selector(handleStarButton), for: .touchUpInside)
		return button
	}()
	
	lazy var infoButtonNavItem: GSInfoButton = {
		let button = GSInfoButton()
		button.addTarget(self, action: #selector(handleInfoButton), for: .touchUpInside)
		button.tintColor = GSSettings.UI.Colors.tintColor
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSubviews()
		getSnapshotForLocation()
		updateViewConstraints()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarDefault()
		setupNavBar()
		containerScrollView.parentVCWillAppear()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	func setupSubviews() {
		self.view.addSubview(self.containerScrollView)
		containerScrollView.delegateDV  = self
		containerScrollView.delegate    = self
	}
	
	func setupConstraints() {
		self.containerScrollView.fillSuperview(onlySafeArea: false)
	}
	
	func setupNavBar() {
		let star = UIBarButtonItem(customView: starButtonNavItem)
		let info = UIBarButtonItem(customView: infoButtonNavItem)
		navigationItem.rightBarButtonItems = [star, info]
	}
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
		self.setupConstraints()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	//MARK: - Methods
	func getSnapshotForLocation() {
		var snapShotter = MKMapSnapshotter()
		let mapSnapshotOptions = MKMapSnapshotter.Options()
		let location = provLocation
		let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
		mapSnapshotOptions.region = region
		mapSnapshotOptions.scale = UIScreen.main.scale
		mapSnapshotOptions.size = CGSize(width: 400, height: 400)
		mapSnapshotOptions.showsBuildings = true
		mapSnapshotOptions.showsPointsOfInterest = true
		snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
		snapShotter.start { (snapshot:MKMapSnapshotter.Snapshot?, error:Error?) in
			self.containerScrollView.mapView.image = snapshot?.image
			self.containerScrollView.mapActivityIndicatorView.stopAnimating()
		}
	}
	
	@objc func handleStarButton() {
		starButtonNavItem.isSelected.toggle()
	}
	
	@objc func handleInfoButton() {
		infoButtonNavItem.isSelected.toggle()
	}
}

extension GSDetailViewController: GSDetailScrollViewDelegate {
	override func viewDidLayoutSubviews() {
		self.view.setNeedsUpdateConstraints()
		let heightOfAllObjects:CGFloat = 2000
		containerScrollView.contentSize = CGSize(width: self.view.frame.width, height: heightOfAllObjects)
		containerScrollView.layoutIfNeeded()
		containerScrollView.heightOfContent.constant = heightOfAllObjects
		containerScrollView.containerView.layoutIfNeeded()
	}
	
	@objc func openInGoogleMaps() {
		let location = provLocation
		let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: location, addressDictionary:nil))
		mapItem.name = "Target location"
		mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
	}
}

extension GSDetailViewController: UIScrollViewDelegate {
	
}
