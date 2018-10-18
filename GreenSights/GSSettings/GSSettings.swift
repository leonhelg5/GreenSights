//
//  GSSettings.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit
import Foundation

struct GSSettings {
	struct UI {
		
		struct Sizes {
			static let sidePadding: CGFloat = 16
			static let cornerRadius: CGFloat = 8
			static let addFriendButtonSize: CGFloat = 60
			static let aspectRatio: CGFloat = 9/16
		}
		
		struct Colors {
			static let regularTextColor         = UIColor.rgb(23, 23, 23, 1)
			static let lightGray                = UIColor.lightGray
			static let midGray                  = UIColor.gray
			static let elementBackgroundColor   = UIColor.rgb(249, 249, 249, 1)
			static let backgroundWhite          = UIColor.white
			static let backgroundGray 			= UIColor.rgb(239, 239, 244, 1)
			static let tintColor                = UIColor.rgb(0, 110, 0, 1)
			static let nightOrange              = UIColor.rgb(255, 149, 0, 1)
		}
		
		struct helperIcons {
			static let chevron = "chevronGray"
		}
		
		struct tabbarItems {
			static let tabbarBackground         = Colors.elementBackgroundColor
			static let selectedItemsTintColor   = Colors.tintColor
			static let unselectedItemsTintColor = UIColor.black//UIColor.darkGray
			
			static let homeSelected     = "home5_selected"
			static let homeUnselected   = "home5_unselected"
			static let searchSelected   = "search_selected"
			static let searchUnselected = "search_unselected"
			static let plusIcon         = "plusIconPDF"
			static let mapSelected      = "map_selected"
			static let mapUnselected    = "map8_unselected"
			static let profileSelected      = "profile_unselected"
			static let profileUnselected    = "profile_unselected"
		}
		
		struct NavBarIcons {
			static let starSelected     = "star_selected"
			static let starUnselected   = "star_unselected"
			static let infoSelected     = "info_selected"
			static let infoUnselected   = "info_unselected"
		}
		
		struct otherIcons {
			static let dotsHorizontal 	= "dot2_horizontal"
			static let dotsVertical 	= "dot2_vertical"
			static let voteLine 		= "line12"
			static let addFriend 		= "addFriend"
		}
		
		struct Animations {
			static let mySwipeDuration = TimeInterval(0.25)
		}
		
		struct Fonts {
			
			static let helveticaThin    = UIFont(name: "HelveticaNeue-Thin", size: 24)
			static let helveticaLight   = UIFont(name: "HelveticaNeue-Light", size: 24)
			static let helveticaRegular = UIFont(name: "HelveticaNeue", size: 24)
			static let helveticaMedium  = UIFont(name: "HelveticaNeue-Medium", size: 24)
			static let helveticaBold    = UIFont(name: "HelveticaNeue-Bold", size: 24)
			
			static let helveticaThinItalic    = UIFont(name: "HelveticaNeue-ThinItalic", size: 24)
			static let helveticaLightItalic   = UIFont(name: "HelveticaNeue-LightItalic", size: 24)
			static let helveticaRegularItalic = UIFont(name: "HelveticaNeue-Italic", size: 24)
			static let helveticaMediumItalic  = UIFont(name: "HelveticaNeue-MediumItalic", size: 24)
			static let helveticaBoldItalic    = UIFont(name: "HelveticaNeue-BoldItalic", size: 24)
		}
	}
}
