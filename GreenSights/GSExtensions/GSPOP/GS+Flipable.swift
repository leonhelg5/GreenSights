//
//  GS+Flip.swift
//  GreenSights
//
//  Created by Leon Helg on 22.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

protocol Flipable { }

extension Flipable where Self: UIView {

    func flip(toRight: Bool, flipView: UIView, viewsToHide: [UIView], viewsToShow: [UIView]) {
        var transitionOptions = UIView.AnimationOptions()
        if toRight {
            transitionOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        } else {
            transitionOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        }
        
        UIView.transition(with: flipView, duration: 0.4, options: transitionOptions, animations: {
            for view in viewsToHide {
                view.isHidden = true
            }
            for view in viewsToShow {
                view.isHidden = false
            }
        }) { (finished) in
            print("Is finished: ",finished)
        }
    }
}
