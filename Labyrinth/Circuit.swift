//
//  Circuit.swift
//  Labyrinth
//
//  Created by James Bean on 9/9/16.
//
//

import Foundation

struct Circuit {
    
    let index: UInt
    let diameter: Float
    var circumference: Float { return Float(M_PI) * diameter }
}
