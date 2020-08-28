//
//  ViewController.swift
//  SnakeAndLadder
//
//  Created by Sudhanshu Sudhanshu on 28/08/20.
//

import UIKit

class ViewController: UIViewController {
    let boardService = BoardService(boardSize: 100)
    
    fileprivate func snakeSetup() {
        var snakes: Set<Snake> = Set<Snake>()
        snakes.insert(Snake(head: 99, tail: 10))
        snakes.insert(Snake(head: 80, tail: 12))
        snakes.insert(Snake(head: 75, tail: 52))
        snakes.insert(Snake(head: 55, tail: 23))
        snakes.insert(Snake(head: 35, tail: 24))
        boardService.setSnakes(snakes)
    }
    
    fileprivate func ladderSetup() {
        var ladder: Set<Ladder> = Set<Ladder>()
        ladder.insert(Ladder(start: 8, end: 18))
        ladder.insert(Ladder(start: 24, end: 80))
        boardService.setLadders(ladder)
    }
    
    fileprivate func playersSetup() {
        var players: [Player] = []
        players.append(Player(name: "Sudhanshu"))
        players.append(Player(name: "Debasmita"))
        boardService.setPlayers(players)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snakeSetup()
        
        ladderSetup()

        playersSetup()
        
        boardService.startGame()
        
    }


}

