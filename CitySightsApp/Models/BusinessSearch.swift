//
//  BusinessSearch.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/4/22.
//

import Foundation

struct BusinessSearch: Decodable{
    
    var businesses = [Buisness]()
    var total = 0
    var region = Region()
    
}
struct Region: Decodable {
    var center = Coordinate()
}
