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
        
        for (a,b) in zip(labyrinth.path.map { $0.circuit.index }, expectedCircuits) {
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
        
        for (a,b) in zip(labyrinth.path.map { $0.quarters }, expectedQuarters) {
            XCTAssertEqual(a,b)
        }
    }
}
