//
//  main.swift
//  tic-tac-toe-basic
//
//  Created by Zdenko Čepan on 20.07.2023.
//

import Foundation

print("Welcome in Tic-Tac-Toe!")

let tracker = GameTracker()
let game = TicTacToe(boardSize: 3, winCount: 3)
game.delegate = tracker
game.play()

