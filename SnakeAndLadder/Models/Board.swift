//
//  Board.swift
//  SnakeAndLadder
//
//  Created by Sudhanshu Sudhanshu on 28/08/20.
//

import UIKit

class Board {
    let size: Int
    var snakes: Set<Snake>
    var ladders: Set<Ladder>
    
    var playerPieces: [String: Int]
    
    init(size: Int) {
        self.size = size
        
        self.snakes = Set<Snake>()
        self.ladders = Set<Ladder>()
        self.playerPieces = [:]
    }
    
    // MARK: - Size Getter
    func getSize() -> Int {
        size
    }
    
    // MARK: - Snake Getter & Setter
    func getSnakes() -> Set<Snake> {
        snakes
    }
    func setSnakes(_ snakes: Set<Snake>) {
        self.snakes = snakes
    }
    
    // MARK: - Ladder Getter & Setter
    func getLadders() -> Set<Ladder> {
        ladders
    }
    func setLadders(_ ladders: Set<Ladder>) {
        self.ladders = ladders
    }
    
    // MARK: - PlayerPieces Getter & Setter
    func getPlayerPieces() -> [String: Int] {
        playerPieces
    }
    func setPlayerPieces(_ playerPieces: [String: Int]) {
        self.playerPieces = playerPieces
    }

}
