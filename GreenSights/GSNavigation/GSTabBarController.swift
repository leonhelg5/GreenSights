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
		
        self.tabBar.backgroundColor = UIColor.red
		for vc in self.viewControllers! {
			vc.tabBarItem.title = nil
			vc.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -6, right: 0)
		}
	}
	
	func setupDefaultProperties() {
		self.view.backgroundColor = GSSettings.UI.Colors.elementBackgroundColor
		self.tabBar.autoresizesSubviews = true
		self.tabBar.clipsToBounds = true
		self.tabBar.isTranslucent = false
		self.tabBar.tintColor = GSSettings.UI.tabbarItems.selectedItemsTintColor
		self.tabBar.unselectedItemTintColor = GSSettings.UI.tabbarItems.unselectedItemsTintColor
		//        self.tabBarItem.imageInsets = UIEdgeInsets(top: -16, left: 0, bottom: 16, right: 0)
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
		let homeSelected        = UIImage(named: GSSettings.UI.tabbarItems.homeSelected)
		let homeUnselected      = UIImage(named: GSSettings.UI.tabbarItems.homeUnselected)
		let searchSelected      = UIImage(named: GSSettings.UI.tabbarItems.searchSelected)
		let searchUnselected    = UIImage(named: GSSettings.UI.tabbarItems.searchUnselected)
		let plusIcon            = UIImage(named: GSSettings.UI.tabbarItems.plusIcon)
		let mapSelected         = UIImage(named: GSSettings.UI.tabbarItems.mapSelected)
		let mapUnselected       = UIImage(named: GSSettings.UI.tabbarItems.mapUnselected)
		let profileSelected     = UIImage(named: GSSettings.UI.tabbarItems.profileSelected)
		let profileUnselected   = UIImage(named: GSSettings.UI.tabbarItems.profileUnselected)
		
		
		//list
		let listViewController = GSListViewController()
		let listNavigationController = GSNavigationController(rootViewController: listViewController)
		listNavigationController.tabBarItem.image = homeUnselected
		listNavigationController.tabBarItem.selectedImage = homeSelected
		listViewController.title = "Sights"
		listNavigationController.tabBarItem.title = ""
        
        let searchNavigationController = templateNavController(unselectedImage: searchUnselected!, selectedImage: searchSelected!, rootViewController: TestVC())
		let addSpotNavigationController = templateNavController(unselectedImage: plusIcon!, selectedImage: plusIcon!)
        let mapNavigationController = templateNavController(unselectedImage: mapUnselected!, selectedImage: mapSelected!, rootViewController: TestVC())
        let cvNavigationController = templateNavController(unselectedImage: profileUnselected!, selectedImage: profileSelected!, rootViewController: GSCollectionOverviewController())

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
