//
//  Game.swift
//  tic-tac-toe-basic
//
//  Created by Zdenko Čepan on 20.07.2023.
//

import Foundation

protocol Game {
    var boardSize: Int { get }
    
    func play()
    func showGameBoard()
}
