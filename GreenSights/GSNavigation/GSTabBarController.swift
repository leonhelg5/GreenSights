//
//  GSTabBarController.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSTabBarController: UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self
		setupDefaultProperties()
		setupViewControllers()
		addTopBorder()
		
		for vc in self.viewControllers! {
			vc.tabBarItem.title = nil
			vc.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -6, right: 0)
		}
	}
	
	func setupDefaultProperties() {
		self.view.backgroundColor = GSSettings.ui.colors.elementBackgroundColor
		self.tabBar.autoresizesSubviews = true
		self.tabBar.clipsToBounds = true
		self.tabBar.isTranslucent = false
		self.tabBar.tintColor = GSSettings.ui.tabbarItems.selectedItemsTintColor
		self.tabBar.unselectedItemTintColor = GSSettings.ui.tabbarItems.unselectedItemsTintColor
	}
	
	//doesnt work
	func addTopBorder() {
		let topBorder               = CALayer()
		topBorder.frame             = CGRect(x: 0, y: 0, width: 1600, height: 0.5)
		topBorder.backgroundColor   = UIColor.lightGray.cgColor
		self.tabBar.layer.addSublayer(topBorder)
	}
	
	func setupViewControllers() {
		//Icons
		let homeSelected        = UIImage(named: GSSettings.ui.tabbarItems.homeSelected)
		let homeUnselected      = UIImage(named: GSSettings.ui.tabbarItems.homeUnselected)
		let searchSelected      = UIImage(named: GSSettings.ui.tabbarItems.searchSelected)
		let searchUnselected    = UIImage(named: GSSettings.ui.tabbarItems.searchUnselected)
		let plusIcon            = UIImage(named: GSSettings.ui.tabbarItems.plusIcon)
		let mapSelected         = UIImage(named: GSSettings.ui.tabbarItems.mapSelected)
		let mapUnselected       = UIImage(named: GSSettings.ui.tabbarItems.mapUnselected)
		let profileSelected     = UIImage(named: GSSettings.ui.tabbarItems.profileSelected)
		let profileUnselected   = UIImage(named: GSSettings.ui.tabbarItems.profileUnselected)
		
		
		let listNavigationController 	= templateNavController(unselectedImage: homeUnselected!, selectedImage: homeSelected!, rootViewController: GSListViewController())
		let searchNavigationController 	= templateNavController(unselectedImage: searchUnselected!, selectedImage: searchSelected!, rootViewController: TestVC())
		let addSpotNavigationController = templateNavController(unselectedImage: plusIcon!, selectedImage: plusIcon!)
		let mapNavigationController 	= templateNavController(unselectedImage: mapUnselected!, selectedImage: mapSelected!, rootViewController: TestVC())
		let cvNavigationController 		= templateNavController(unselectedImage: profileUnselected!, selectedImage: profileSelected!, rootViewController: GSCollectionOverviewController())
		
		viewControllers = [listNavigationController, searchNavigationController , addSpotNavigationController, mapNavigationController, cvNavigationController]
	}
	
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		let index = viewControllers?.index(of: viewController)
		if index == 2 {
			let photoSelectorController = GSPhotoSelectorController()
			let navController = GSNavigationController(rootViewController: photoSelectorController)
			present(navController, animated: true, completion: nil)
			return false
		}
		return true
	}
	
	fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
		let viewController = rootViewController
		let navController = GSNavigationController(rootViewController: viewController)
		navController.tabBarItem.image = unselectedImage
		navController.tabBarItem.selectedImage = selectedImage
		return navController
	}
}
