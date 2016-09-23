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
    
    public var path: Path {
        
        let count = circuits.count
        let max = UInt(circuits.count - 1)
        let middle = UInt(count / 2)
        
        func retrograde(sequence: [(UInt, UInt)]) -> [(UInt, UInt)] {
            return Array(
                zip(
                    sequence.map { max - $0.0 },
                    sequence.map { $0.1 }
                ).reversed()
            )
        }
        
        // Ensure this is generalizable beyond 11-circuit Chartres labyrinth
        let intro: [(UInt, UInt)] = [(middle - 1, 1), (middle, 1)]
        
        // TODO: Generalize `7` into relation to middle for arbirtrary-dimensions
        let segmentA: [(UInt, UInt)] = Array(zip((7...max).reversed(), [2,2,1,1]))
        
        // TODO: Generalize `6` into relation to middle for arbirtrary-dimensions
        let segmentB: [(UInt, UInt)] = Array(zip((6...(max - 1)), [2,1,2,1]))
        
        // TODO: Generalize `6` into relation to middle for arbirtrary-dimensions
        let segmentC: [(UInt, UInt)] = Array(zip((6...max).reversed(), [2,1,1,2,1]))
        
        // FIXME: Ensure odd- and even-dimensioned structures work appropriately
        let center: [(UInt, UInt)] = [((max / 2), 2)]
        
        // First half
        let beginning: [[(UInt, UInt)]] = [intro, segmentA, segmentB, segmentC]
        
        // Second half
        let ending = beginning.reversed().map(retrograde)
        
        return Path(
            (beginning + [center] + ending)
                .flatMap { $0 }
                .map { (i, quarters) in
                    Labyrinth.Segment(circuit: circuits[Int(i)], quarters: quarters)
                }
        )
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
