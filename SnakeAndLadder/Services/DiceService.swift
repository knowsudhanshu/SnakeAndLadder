//
//  DiceService.swift
//  SnakeAndLadder
//
//  Created by Sudhanshu Sudhanshu on 28/08/20.
//

import UIKit

class DiceService {
    public static func roll() -> Int {
        Int.random(in: 1...6)
    }
}
