//
//  TicTacToe.swift
//  tic-tac-toe-basic
//
//  Created by Zdenko Čepan on 20.07.2023.
//

import Foundation

class TicTacToe: Game {
    let boardSize: Int
    let winCount: Int
    let player1Symbol: Character = "#"
    let player2Symbol: Character = "*"
    let emptySymbol: Character = "."
    var winner: Int?
    var board: [[Character]]
    init(boardSize: Int, winCount: Int) {
        self.boardSize = boardSize
        self.winCount = boardSize <= winCount ? boardSize : winCount
        board = Array(repeating: Array(repeating: emptySymbol, count: boardSize), count: boardSize)
    }
    
    weak var delegate: GameDelegate?
    
    typealias RowCoor = Int
    typealias ColCoor = Int
    typealias Coordinations = (col: ColCoor, row: RowCoor)// where Int < boardSize
    
    func play() {
        board = Array(repeating: Array(repeating: ".", count: boardSize), count: boardSize)
        delegate?.gameDidStart(self)
        
        gameLoop: while !isEnd() {
            showGameBoard()
            var player1: Coordinations?
            while !isValidCoor(player: player1) {
                player1 = playerChoice()!
            }
            writeSymbol(player: player1, symbol: player1Symbol)
            
            guard !isEnd() else {
                break gameLoop
            }
            
            showGameBoard()
            var player2: Coordinations?
            while !isValidCoor(player: player2) {
                player2 = playerChoice()!
            }
            writeSymbol(player: player2, symbol: player2Symbol)
            
            delegate?.gameTurn(self)
            
        }
        delegate?.gameDidEnd(self, winner: winner!)
    }
    
    private func playerChoice() -> Coordinations? {
        while true {
            do {
                let col = try playerInput(coor: "col")
                let row = try playerInput(coor: "row")
                return (col: col, row: row)
            } catch {}
        }
    }
    
    private func playerInput(coor: String) throws -> Int {
        print("What is your choice for \(coor)?")
        guard let input = readLine() else {
            print("You didnt write anything for \(coor).")
            throw InputError.EmptyInput
        }
        
        guard let output = Int(input) else {
            print("You didnt write number for \(coor).")
            throw InputError.InvalidType
        }
        
        return output
    }
    
    private func isValidCoor(player: Coordinations?) -> Bool {
        let coor: Coordinations = player ?? (row: -1, col: -1)
        
        guard 0 ... boardSize - 1 ~= coor.row else {
            print("Your row coor is out of range.")
            return false
        }
        
        guard 0 ... boardSize - 1 ~= coor.col else {
            print("Your col coor is out of range.")
            return false
        }
        
        guard board[coor.col][coor.row] == emptySymbol else {
            print("Your choice is out of actual posibilities.")
            return false
        }
        
        return true
        /*
        if player?.row ?? -1 < 0 || player?.row ?? boardSize + 1 > boardSize {
            return false
        }
        */
    }
    
    private func writeSymbol(player: Coordinations?, symbol: Character) -> Void {
        board[player!.col][player!.row] = symbol
    }
    
    func showGameBoard() {
        for row in board {
            for col in row {
                print(col, terminator: " | ")
            }
            print("")
        }
    }
    
    private func isEnd() -> Bool {
        
        return false
    }
}
