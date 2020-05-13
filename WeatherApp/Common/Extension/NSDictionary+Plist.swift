//
//  NSDictionary+Plist.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

extension NSDictionary {
    static func readingPlist(plistFile: String?) -> NSDictionary? {
        guard let path = Bundle.main.path(forResource: plistFile, ofType: "plist")
        else { return nil }
        return NSDictionary(contentsOfFile: path)
    }
}
