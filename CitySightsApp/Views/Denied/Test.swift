//
//  Test.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/8/22.
//

import SwiftUI

struct Test: View {
    
    var model:ContentModel
    
    var body: some View {
        Text("\(model.arts.count)")
    }
}

