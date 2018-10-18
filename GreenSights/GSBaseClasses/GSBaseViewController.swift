//
//  GSBaseViewController.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSBaseViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
	}
	
	func changeViewTo(newView: UIView, oldView: UIView) {
		if oldView == newView { return }
		newView.isHidden = false
		newView.alpha = 0
		UIView.animate(withDuration:0.4, animations: {
			oldView.alpha = 0
			newView.alpha = 1
		}) { (result: Bool) in
			oldView.isHidden = true
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		(UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all
	}
}
