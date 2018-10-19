//
//  GSPinterestCekk.swift
//  GreenSights
//
//  Created by Leon Helg on 19.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit


class GSPinterestCell: UICollectionViewCell, ReusableView {
    
    var data: Datasource?
    
    let photoImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = GSSettings.ui.colors.backgroundWhite
        setupSubviews()
        setupContstraints()
    }
    
    func setupSubviews() {
        //addSubview(photoImageView)
        addSubview(typeLabel)
    }
    
    func setupContstraints() {
        //photoImageView.fillSuperview(onlySafeArea: false)
        typeLabel.fillSuperview(onlySafeArea: true)
    }
    
    func configure(dataSource: Datasource?) {
        guard let dataSource = dataSource else { return }
        data = dataSource
        guard let type = data?.type else { return }
        typeLabel.text = "\(type)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
