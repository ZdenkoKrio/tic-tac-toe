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
    var winner: Int?
    var board: [[Symbol]]
    init(boardSize: Int, winCount: Int) {
        self.boardSize = boardSize
        self.winCount = boardSize <= winCount ? boardSize : winCount
        board = Array(repeating: Array(repeating: .emptySymbol, count: boardSize), count: boardSize)
    }
    
    weak var delegate: GameDelegate?
    
    typealias RowCoor = Int
    typealias ColCoor = Int
    typealias Coordinations = (col: ColCoor, row: RowCoor)// where Int < boardSize
    
    func play() {
        board = Array(repeating: Array(repeating: .emptySymbol, count: boardSize), count: boardSize)
        delegate?.gameDidStart(self)
        
        gameLoop: while !isEnd() {
            showGameBoard()
            var player1: Coordinations?
            while !isValidMove(player: player1) {
                player1 = playerChoice()!
            }
            writeSymbol(player: player1, symbol: .player1)
            
            guard !isEnd() else {
                break gameLoop
            }
            
            showGameBoard()
            var player2: Coordinations?
            while !isValidMove(player: player2) {
                player2 = playerChoice()!
            }
            writeSymbol(player: player2, symbol: .player2)
            
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
    
    private func isValidMove(player: Coordinations?) -> Bool {
        guard let coor: Coordinations = player else {
            return false
        }
       
        guard 0 ... boardSize - 1 ~= coor.row else {
            print("Your row coor is out of range.")
            return false
        }
        
        guard 0 ... boardSize - 1 ~= coor.col else {
            print("Your col coor is out of range.")
            return false
        }
        
        guard board[coor.col][coor.row] == .emptySymbol else {
            print("Your choice is out of actual posibilities.")
            return false
        }
        
        return true
        /*
        if player?.row ?? -1 < 0 || player?.row ?? boardSize + 1 > boardSize {
            return false
        }
        */
        
        /*
        switch coor {
        case (0...boardSize-1, 0...boardSize-1):
            print("coor is correct")
            return true
        default:
            print("coor is out of range")
            return false
        }
         */
    }
    
    private func isValidCoor(player: Coordinations) -> Bool {
        guard 0 ... boardSize - 1 ~= player.row else {
            return false
        }
        
        guard 0 ... boardSize - 1 ~= player.col else {
            return false
        }
        
        return true
    }
    
    private func writeSymbol(player: Coordinations?, symbol: Symbol) -> Void {
        board[player!.col][player!.row] = symbol
    }
    
    func showGameBoard() {
        for row in board {
            for cell in row {
                print(cell.rawValue, terminator: " | ")
            }
            print("")
        }
    }
    
    private func isEnd() -> Bool {
        for col in 0...boardSize-1 {
            rows: for row in 0...boardSize-1 {
                guard board[col][row] != .emptySymbol else {
                    continue rows
                }
                
                guard !(checkLines(point: (col, row)) || checkDiagonals(point: (col, row))) else {
                    markWinner(symbol: board[col][row])
                    return true
                }
            }
        }
        return false
    }
    
    private func checkLines(point: Coordinations) -> Bool {
        return checkVLine(point: point) || checkHLine(point: point)
    }
    
    private func checkHLine(point: Coordinations) -> Bool {
        for row in point.row...point.row+winCount-1 {
            guard isValidCoor(player: (point.col, row)) else {
                return false
            }
            
            guard board[point.col][point.row] == board[point.col][row] else {
                return false
            }
        }
        return true
    }
    
    private func checkVLine(point: Coordinations) -> Bool {
        for col in point.col...point.col+winCount-1 {
            guard isValidCoor(player: (col, point.row)) else {
                return false
            }
            
            guard board[point.col][point.row] == board[col][point.row] else {
                return false
            }
        }
        return true
    }
    
    private func checkDiagonals(point: Coordinations) -> Bool {
        return checkPrimaryDiagonal(point: point) || checkSecondaryDiagonal(point: point)
    }
    
    private func checkPrimaryDiagonal(point: Coordinations) -> Bool {
        for shift in 0...winCount {
            guard isValidCoor(player: (point.col + shift, point.row + shift)) else {
                return false
            }
            
            guard board[point.col][point.row] == board[point.col + shift][point.row + shift] else {
                return false
            }
        }
        return true
    }
    
    private func checkSecondaryDiagonal(point: Coordinations) -> Bool {
        for shift in 0...winCount {
            guard isValidCoor(player: (point.col - shift, point.row + shift)) else {
                return false
            }
            
            guard board[point.col][point.row] == board[point.col - shift][point.row + shift] else {
                return false
            }
        }
        return true
    }
    
    private func markWinner(symbol: Symbol) -> Void {
        winner = symbol == .player1 ? 1 : 2
    }
}
