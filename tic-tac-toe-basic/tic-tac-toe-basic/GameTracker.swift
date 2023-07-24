//
//  GameTracker.swift
//  tic-tac-toe-basic
//
//  Created by Zdenko Čepan on 20.07.2023.
//

import Foundation

class GameTracker: GameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: Game) {
        numberOfTurns = 0
        if game is TicTacToe {
            print("Started a new game of TicTacToe")
        }
        print("The game is using a \(game.boardSize) square board")
    }
    
    func gameTurn(_ game: Game) {
        numberOfTurns += 1
    }
    
    func gameDidEnd(_ game: Game, winner: Int) {
        print("The game lasted for \(numberOfTurns) turns and winner is player number \(winner)")
    }
}
