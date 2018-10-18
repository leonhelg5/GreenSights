//
//  GSDetailSpotStructure.swift
//  GreenSights
//
//  Created by Leon Helg on 09.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import Foundation
import MapKit

struct Spot {
	//General
	var Titel: String
	var Subtitle: String?
	var Description: String?
	var Thumbnail: String
	var Fotos: [String]?
	var Location: CLLocationCoordinate2D
	
	//Detail
	var Seating: Bool?
	var SeatingCapacity: Int32?
	var Rainproof: Bool?
	var Windproof: Bool?
	var Noisetolerance: AmountOfNoisetolerance?
	var Policepresence: AmountOfPolicepresence?
	var Residents: AmountOfPeople?
	var Passers: AmountOfPeople?
	var Reachability: Reachability?
	
	//Variable
	var Reputation: UInt64
	var AllTimeVisitors: Int64
	var CurrentVisitors: Int64
	
	//Behind the Scenes
	var Author: [Dictionary<Date, Any>]
	var Editors: [Dictionary<Date, Any>]
}

enum AmountOfNoisetolerance {
	case none
	case little
	case medium
	case hard
	case noworries
}

enum AmountOfPolicepresence {
	case none
	case little
	case occasionally
	case much
	case allthetime
}

enum AmountOfPeople {
	case none
	case little
	case medium
	case many
	case toomany
}

enum Reachability {
	case verybad
	case bad
	case medium
	case good
	case verygood
}

