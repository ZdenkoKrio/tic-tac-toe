//
//  GameDelegate.swift
//  tic-tac-toe-basic
//
//  Created by Zdenko Čepan on 20.07.2023.
//

import Foundation

protocol GameDelegate: AnyObject {
    func gameDidStart(_ game: Game)
    func gameTurn(_ game: Game)
    func gameDidEnd(_ game: Game, winner: Int)
}
