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
    var path: Path!
    
    let secondHalf: (UInt) -> ([(UInt, UInt)]) -> [(UInt, UInt)] = { max in
        return { firstHalf in
            let firstHalf = firstHalf.reversed()
            return Array(
                zip(
                    firstHalf.map { max - $0.0 },
                    firstHalf.map { $0.1 }
                )
            )
        }
    }
    
    override func setUp() {
        
        let count = labyrinth.circuits.count
        let max = UInt(labyrinth.circuits.count - 1)
        let middle = UInt(count / 2)

        // 11-circuit Chartres labyrinth
        let intro: [(UInt, UInt)] = [(middle - 1, 1), (middle, 1)]
        let segmentA: [(UInt, UInt)] = Array(zip((7...max).reversed(), [2,2,1,1]))
        let segmentB: [(UInt, UInt)] = Array(zip((6...(max - 1)), [2,1,2,1]))
        let segmentC: [(UInt, UInt)] = Array(zip((6...max).reversed(), [2,1,1,2,1]))
        let center: [(UInt, UInt)] = [((max / 2), 2)]
        
        let beginning: [[(UInt, UInt)]] = [intro, segmentA, segmentB, segmentC]

        let ending = beginning.reversed().map(secondHalf(max))
        
        let segments = (beginning + [center] + ending)
            .flatMap { $0 }
            .map { (i, quarters) in
              Segment(circuit: labyrinth.circuits[Int(i)], quarters: quarters)
        }
        
        self.path = Path(segments)
        print(path)
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
