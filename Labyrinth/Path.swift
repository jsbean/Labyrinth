//
//  Path.swift
//  Labyrinth
//
//  Created by James Bean on 9/9/16.
//
//

import Foundation

struct Path {
    
    fileprivate var segments: [Segment] = []
    
    init(_ segments: [Segment]) {
        self.segments = segments
    }
    
    mutating func append(path: Path) {
        segments.append(contentsOf: path.segments)
    }
}

extension Path: Sequence {
    
    func makeIterator() -> AnyIterator<Segment> {
        var iterator = segments.makeIterator()
        return AnyIterator { return iterator.next() }
    }
}

extension Path: CustomStringConvertible {
    
    var description: String {
        return "\(segments)"
    }
}
