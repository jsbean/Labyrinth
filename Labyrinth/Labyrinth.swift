//
//  Labyrinth.swift
//  Labyrinth
//
//  Created by James Bean on 9/9/16.
//
//

import Foundation

public struct Labyrinth {
    
    public struct Circuit {
        
        let index: UInt
        let diameter: Float
        var circumference: Float { return Float(M_PI) * diameter }

        public init(index: UInt, diameter: Float) {
            self.index = index
            self.diameter = diameter
        }
    }
    
    public struct Segment {
        
        public let circuit: Circuit
        public let quarters: UInt
        public var length: Float { return circuit.circumference * (Float(quarters) / 4) }
        
        public init(circuit: Circuit, quarters: UInt) {
            self.circuit = circuit
            self.quarters = quarters
        }
    }
    
    public struct Path {
        
        fileprivate var segments: [Segment] = []
        
        init(_ segments: [Segment]) {
            self.segments = segments
        }
        
        mutating func append(path: Path) {
            segments.append(contentsOf: path.segments)
        }
    }

    public let circuits: [Circuit]
    
    public init(amountCircuits: UInt, centerProportion: Float = 0.25) {
        let circuitWidth = (1.0 - centerProportion) / (Float(amountCircuits - 1))
        self.circuits = (0 ..< amountCircuits).map { i in
            return Circuit(index: i, diameter: 1.0 - Float(i) * circuitWidth)
        }
    }
}

extension Labyrinth.Path: Sequence {
    
    public func makeIterator() -> AnyIterator<Labyrinth.Segment> {
        var iterator = segments.makeIterator()
        return AnyIterator { return iterator.next() }
    }
}

extension Labyrinth.Path: CustomStringConvertible {
    
    public var description: String {
        return "\(segments)"
    }
}
