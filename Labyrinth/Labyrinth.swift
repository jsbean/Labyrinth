//
//  Labyrinth.swift
//  Labyrinth
//
//  Created by James Bean on 9/9/16.
//
//

import Foundation

struct Labyrinth {
    
    private let centerProportion: Float // 0...1
    
    let circuits: [Circuit]
    
    init(amountCircuits: UInt, centerProportion: Float = 0.25) {
        self.centerProportion = centerProportion
        let circuitWidth = (1.0 - centerProportion) / (Float(amountCircuits - 1))
        self.circuits = (0 ..< amountCircuits).map { i in
            return Circuit(index: i, diameter: 1.0 - Float(i) * circuitWidth)
        }
    }
}
