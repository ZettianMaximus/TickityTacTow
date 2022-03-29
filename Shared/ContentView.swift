//
//  ContentView.swift
//  Shared
//
//  Created by Jared Davidson on 5/28/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    //@State var homeTurn : Bool = true
    
    
    func buttonAction(_ index : Int) {
        if ticTacToeModel.homeTurn {
            _ = self.ticTacToeModel.makeMove(index: index, player: .home)
            self.ticTacToeModel.allowTurnChange()
            //homeTurn = true
//        } else if homeTurn == true {
//            _ = self.ticTacToeModel.makeMove(index: index, player: .home)
                //homeTurn = false
        } else {
            _ = self.ticTacToeModel.makeMove(index: index, player: .visitor)
            self.ticTacToeModel.allowTurnChange()
            //homeTurn = true
        }
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    
    
    var body: some View {
        VStack {
            
            Button("Toggle AI") {
                self.ticTacToeModel.toggleAI()
                self.gameOver = self.ticTacToeModel.gameOver.1
                //homeTurn = true
            }.buttonStyle(.automatic)
            
            Text("Tickity Tac Toe")
                .bold()
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.bottom)
                .font(.title2)
            
            ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column  // # of squares
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {self.buttonAction(index)})
                    })
                }
            })
        }
        .alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("Game Over"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "X Wins!": "O Wins!" : "Nobody Wins!" ) , dismissButton: Alert.Button.destructive(Text("Okay"), action: {
                    self.ticTacToeModel.resetGame()
                  }))
        })
        .environmentObject(ticTacToeModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TicTacToeModel())
    }
}
