//
//  ElevenCircuitLabyrinthTests.swift
//  Labyrinth
//
//  Created by James Bean on 9/9/16.
//
//

import XCTest
@testable import Labyrinth

class ElevenCircuitLabyrinthTests: XCTestCase {

    let labyrinth = Labyrinth(amountCircuits: 11)
    var path: Labyrinth.Path!
    
    // TODO: Refactor this into the framework, encapsulated beneath some structure's interface
    let secondHalf: (UInt) -> ([(UInt, UInt)]) -> [(UInt, UInt)] = { max in
        return { firstHalf in
            return Array(zip(firstHalf.map { max - $0.0 }, firstHalf.map { $0.1 }).reversed())
        }
    }
    
    override func setUp() {
        
        let count = labyrinth.circuits.count
        let max = UInt(labyrinth.circuits.count - 1)
        let middle = UInt(count / 2)

        // 11-circuit Chartres labyrinth
        let intro: [(UInt, UInt)] = [(middle - 1, 1), (middle, 1)]
        
        // TODO: Generalize `7` into relation to middle
        let segmentA: [(UInt, UInt)] = Array(zip((7...max).reversed(), [2,2,1,1]))
        
        // TODO: Generalize `6` into relation to middle
        let segmentB: [(UInt, UInt)] = Array(zip((6...(max - 1)), [2,1,2,1]))
        
        // TODO: Generalize `6` into relation to middle
        let segmentC: [(UInt, UInt)] = Array(zip((6...max).reversed(), [2,1,1,2,1]))
        
        // FIXME: Ensure odd- and even-dimensioned structures work appropriately
        let center: [(UInt, UInt)] = [((max / 2), 2)]
        
        // First half
        let beginning: [[(UInt, UInt)]] = [intro, segmentA, segmentB, segmentC]

        // Second half
        let ending = beginning.reversed().map(secondHalf(max))
        
        let segments = (beginning + [center] + ending)
            .flatMap { $0 }
            .map { (i, quarters) in
              Labyrinth.Segment(circuit: labyrinth.circuits[Int(i)], quarters: quarters)
        }
        
        self.path = Labyrinth.Path(segments)
    }

    func testCircuits() {
        let expectedCircuits: [UInt] = [
            4, 5, 10,
            9, 8, 7,
            6, 7, 8, 9,
            10, 9, 8, 7, 6,
            5, // middle
            4, 3, 2, 1, 0,
            1, 2, 3, 4,
            3, 2, 1,
            0, 5, 6
        ]
        
        for (a,b) in zip(path.map { $0.circuit.index }, expectedCircuits) {
            XCTAssertEqual(a,b)
        }
    }
    
    func testQuarters() {
        
        let expectedQuarters: [UInt] = [
            1, 1, 2,
            2, 1, 1,
            2, 1, 2, 1,
            2, 1, 1, 2, 1,
            2,
            1, 2, 1, 1, 2,
            1, 2, 1, 2,
            1, 1, 2,
            2, 1, 1
        ]
        
        for (a,b) in zip(path.map { $0.quarters }, expectedQuarters) { XCTAssertEqual(a,b) }
    }
}
