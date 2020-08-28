//
//  BoardService.swift
//  SnakeAndLadder
//
//  Created by Sudhanshu Sudhanshu on 28/08/20.
//

import UIKit



let DEFAULT_BOARD_SIZE: Int = 100
let DEFAULT_NUMBER_OF_DICES: Int = 1

class PlayerQueueHandler {
    var players: [Player]
    init(players: [Player]) {
        self.players = players
    }
    
    public func poll() -> Player? {
        // Get the player in front of the queue
        let player = self.players.first
        self.players.removeFirst()
        
        return player
    }
    
    public func add(_ player: Player) {
        self.players.append(player)
    }
}

class BoardService {
    private let board: Board
    private var initialNumberOfPlayers: Int = 0
    private var playerQueueHandler: PlayerQueueHandler
    
    private var gameOver: Bool = false
    
    private var numberOfDice: Int = DEFAULT_NUMBER_OF_DICES
    
    private var shouldGameContinueTillLastPlayer: Bool = false
    
    private var shouldAllowMultipleDiceRollOnSix: Bool = false
    
    init(boardSize: Int) {
        self.board = Board(size: boardSize)
        playerQueueHandler = PlayerQueueHandler(players: [Player]())
    }
    
    
    public func setNumberOfDices(_ number: Int) {
        self.numberOfDice = number
    }
    
    public func setShouldGameContinueTillLastPlayer(_ bool: Bool) {
        self.shouldGameContinueTillLastPlayer = bool
    }
    
    public func setShouldAllowMultipleDiceRollOnSix(_ bool: Bool) {
        self.shouldAllowMultipleDiceRollOnSix = bool
    }
    
    /// `Initialization`: Board and component
    public func setPlayers(_ players: [Player]) {

        self.initialNumberOfPlayers = players.count
        var playerPieces = [String: Int]()
        for player in players {
            playerQueueHandler.add(player)
            playerPieces[player.getId()] = 0
        }
        
        board.setPlayerPieces(playerPieces)
    }
    
    public func setSnakes(_ snakes: Set<Snake>) {
        board.setSnakes(snakes)
    }
    
    public func setLadders(_ ladders: Set<Ladder>) {
        board.setLadders(ladders)
    }
     
    
    /// `Core business logic`
    public func getNewPositionAfterGoingThroughUpcomingSnakesAndLadders(calculatedPosition: Int) -> Int {
        var calculatedPosition = calculatedPosition
        var prevPosition: Int = -1
        
        while prevPosition != calculatedPosition {
            prevPosition = calculatedPosition
            
            for snake in board.getSnakes() {
                if snake.getHead() == calculatedPosition {
                    calculatedPosition = snake.getTail()
                    print("Snake: \(snake.getHead()) ~~~~~> \(snake.getTail())")
                }
            }
            
            for ladder in board.getLadders() {
                if ladder.getStart() == calculatedPosition {
                    calculatedPosition = ladder.getEnd()
                    print("Ladder: \(ladder.getStart()) ~~~~~> \(ladder.getEnd())")
                }
            }
        }
        
        return calculatedPosition
    }
    
    public func movePlayer(player: Player, to position: Int) {
        guard let oldPosition = board.getPlayerPieces()[player.getId()] else { return }
        var newPosition = oldPosition + position
        
        let boardSize: Int = board.getSize()
        
        if newPosition > boardSize {
            newPosition = oldPosition
        }else {
            newPosition = getNewPositionAfterGoingThroughUpcomingSnakesAndLadders(calculatedPosition: newPosition)
        }
        
        var playerPieces = board.getPlayerPieces()
        playerPieces[player.getId()] = newPosition
        board.setPlayerPieces(playerPieces)
        
        print("\(player.getName()) rolled a \(position) and moved to \(newPosition)")
    }
    
    private func getTotalValueAfterDiceRoll() -> Int {
        var diceValue = DiceService.roll()
        if shouldAllowMultipleDiceRollOnSix && diceValue == 6 {
            print("Dice roll ended up with 6")
            diceValue = diceValue + getTotalValueAfterDiceRoll()
        }
        return diceValue
    }
    
    private func hasPlayerWon(_ player: Player) -> Bool {
        board.getSize() == board.getPlayerPieces()[player.getId()]
    }
    
    private func isGameCompleted() -> Bool {
        let remainingPlayers = playerQueueHandler.players.count
        
        if shouldGameContinueTillLastPlayer {
            return remainingPlayers == 0
        }
        else if remainingPlayers < initialNumberOfPlayers {
            return true
        }
        else {
            return false
        }
    }
    
    public func startGame() {
        while(!isGameCompleted()) {
            guard let currentPlayer = playerQueueHandler.poll() else { return }
            
            let diceValue = getTotalValueAfterDiceRoll()
            
            movePlayer(player: currentPlayer, to: diceValue)
            
            if hasPlayerWon(currentPlayer) {
                print(currentPlayer.getName() + " wins the game.")
                var playerPieces = board.getPlayerPieces()
                playerPieces.removeValue(forKey: currentPlayer.getId())
                board.setPlayerPieces(playerPieces)
            }else {
                playerQueueHandler.add(currentPlayer)
            }
        }
    }
}
