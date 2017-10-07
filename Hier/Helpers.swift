//
//  Helpers.swift
//  Hier
//
//  Created by Yang Zhao on 9/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import MapKit

class Helpers {
    public static func parseAddress(selectedItem: CLPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let firstComma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a comma between "Washington" and "DC"
        let secondComma = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "CA" and "94305"
        let secondSpace = (selectedItem.administrativeArea != nil && selectedItem.postalCode != nil) ? " ": ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            firstComma,
            // city
            selectedItem.locality ?? "",
            secondComma,
            // state
            selectedItem.administrativeArea ?? "",
            secondSpace,
            // postal
            selectedItem.postalCode ?? ""
        )
        return addressLine
    }
}
