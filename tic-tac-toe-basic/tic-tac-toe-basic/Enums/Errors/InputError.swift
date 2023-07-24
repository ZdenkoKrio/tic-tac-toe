//
//  InputErrors.swift
//  tic-tac-toe-basic
//
//  Created by Zdenko Čepan on 20.07.2023.
//

import Foundation

enum InputError: Error {
    case WrongCoordinate
    case InvalidType
    case EmptyInput
}
