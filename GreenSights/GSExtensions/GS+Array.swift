//
//  GS+Array.swift
//  GreenSights
//
//  Created by Leon Helg on 21.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {
	func containsSameElements(as other: [Element]) -> Bool {
		return self.count == other.count && self.sorted() == other.sorted()
	}
}
