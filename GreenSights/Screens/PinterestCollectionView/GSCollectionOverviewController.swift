//
//  GSCollectionOverviewController.swift
//  GreenSights
//
//  Created by Leon Helg on 17.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSCollectionOverviewController: GSBaseViewController {

    let containerView = GSCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        updateViewConstraints()
        setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.parentVCDidAppear()
    }
    
    func setupSubview() {
        self.view.addSubview(self.containerView)
        //containerView.delegate = self
    }
    
    func setupConstraints() {
        self.containerView.fillSuperview(onlySafeArea: true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.setupConstraints()
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(resetOrder))
    }
    
    @objc func resetOrder() {
        containerView.resetLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
