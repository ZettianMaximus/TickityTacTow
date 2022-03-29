//
//  TicTacToeModel.swift
//  TickityTacTow
//
//  Created by Jared Davidson on 5/28/21.
//

import Foundation
import SwiftUI

class TicTacToeModel : ObservableObject {
    @Published var squares = [Square]()
    @Published var toggleAIvar : Bool = true
    @Published var homeTurn : Bool = true
    
    
    init() {
        for _ in 0...8 {
            squares.append(Square(status: .empty))
        }
    }
    
    func resetGame() {
        for i in 0...8 {
            squares[i].squareStatus = .empty
        }
        homeTurn = true
    }
    
    var gameOver : (SquareStatus, Bool) {
        get {
            if thereIsAWinner != .empty {
                return (thereIsAWinner, true)
            } else {
                for i in 0...8 {
                    if squares[i].squareStatus == .empty {
                        return(.empty, false)
                    }
                }
                return (.empty, true)
            }
        }
    }
    
    private var thereIsAWinner: SquareStatus {
        get {
            if let check = self.checkIndexes([0, 1, 2]) {
                return check
            } else  if let check = self.checkIndexes([3, 4, 5]) {
                return check
            }  else  if let check = self.checkIndexes([6, 7, 8]) {
                return check
            }  else  if let check = self.checkIndexes([0, 3, 6]) {
                return check
            }  else  if let check = self.checkIndexes([1, 4, 7]) {
                return check
            }  else  if let check = self.checkIndexes([2, 5, 8]) {
                return check
            }  else  if let check = self.checkIndexes([0, 4, 8]) {
                return check
            }  else  if let check = self.checkIndexes([2, 4, 6]) {
                return check
            }
            return .empty
        }
    }
    
    private func checkIndexes(_ indexes : [Int]) -> SquareStatus? {
        var homeCounter : Int = 0
        var visitorCounter : Int = 0
        for index in indexes {
            let square = squares[index]
            if square.squareStatus == .home {
                homeCounter += 1
            } else if square.squareStatus == .visitor {
                visitorCounter += 1
            }
        }
        if homeCounter == 3 {
            return .home
        } else if visitorCounter == 3 {
            return .visitor
        }
        return nil
    }
    
    private func moveAI() {
        var index = Int.random(in: 0...8)
        while makeMove(index: index, player: .visitor) == false && gameOver.1 == false {
            index = Int.random(in: 0...8)
        }
    }
    
    func toggleAI() {
        if toggleAIvar == true
        {
            toggleAIvar = false
            resetGame()
        }
        else
        {
            toggleAIvar = true
            resetGame()
        }
    }
    
    func allowTurnChange() {
        if toggleAIvar == false {
            if homeTurn == true {
                homeTurn = false
            } else {
                homeTurn = true
            }
        }
    }
    
    func makeMove(index: Int, player: SquareStatus) -> Bool
    {
        if squares[index].squareStatus == .empty
        {  //is the square empty?
            squares[index].squareStatus = player
            if toggleAIvar == true
            {
                if player == .home
                {
                    moveAI()
                }
            }
            else
            {
                //allowTurnChange()
            }
            return true
        }
        allowTurnChange()
        return false
    }
    
}
