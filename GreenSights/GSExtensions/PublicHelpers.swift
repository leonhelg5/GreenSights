//
//  PublicHelpers.swift
//  GreenSights
//
//  Created by Leon Helg on 20.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import Foundation

//https://stackoverflow.com/a/37732282/10151464
public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
	let dispatchTime = DispatchTime.now() + seconds
	dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
}

public enum DispatchLevel {
	case main, userInteractive, userInitiated, utility, background
	var dispatchQueue: DispatchQueue {
		switch self {
		case .main:                 return DispatchQueue.main
		case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
		case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
		case .utility:              return DispatchQueue.global(qos: .utility)
		case .background:           return DispatchQueue.global(qos: .background)
		}
	}
}
