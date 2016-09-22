//
//  Segment.swift
//  Labyrinth
//
//  Created by James Bean on 9/9/16.
//
//

import Foundation

struct Segment {
    
    let circuit: Circuit
    let quarters: UInt
    var length: Float { return circuit.circumference * (Float(quarters) / 4) }
    
    init(circuit: Circuit, quarters: UInt) {
        self.circuit = circuit
        self.quarters = quarters
    }
}
