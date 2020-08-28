//
//  Ladder.swift
//  SnakeAndLadder
//
//  Created by Sudhanshu Sudhanshu on 28/08/20.
//

import UIKit

class Ladder {
    private let start: Int
    private let end: Int
    
    init(start: Int, end: Int) {
        self.start = start
        self.end = end
    }
    
    func getStart() -> Int {
        start
    }
    
    func getEnd() -> Int {
        end
    }
}

extension Ladder: Hashable {
    func hash(into hasher: inout Hasher) {
        
    }
    static func == (lhs: Ladder, rhs: Ladder) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}
