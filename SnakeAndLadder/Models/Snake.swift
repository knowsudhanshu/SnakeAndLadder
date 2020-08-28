//
//  Snake.swift
//  SnakeAndLadder
//
//  Created by Sudhanshu Sudhanshu on 28/08/20.
//

import UIKit

class Snake {
    private let head: Int
    private let tail: Int
    
    init(head: Int, tail: Int) {
        self.head = head
        self.tail = tail
    }
    
    func getHead() -> Int {
        head
    }
    
    func getTail() -> Int {
        tail
    }
}

extension Snake: Hashable {
    
    func hash(into hasher: inout Hasher) {
        
    }
    static func == (lhs: Snake, rhs: Snake) -> Bool {
        return lhs.head == rhs.head && lhs.tail == rhs.tail
    }
}
