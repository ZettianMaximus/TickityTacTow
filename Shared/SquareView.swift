//
//  SquareView.swift
//  TickityTacTow
//
//  Created by Jared Davidson on 5/28/21.
//

import Foundation
import SwiftUI

enum SquareStatus {
    case empty // inactive square
    case home //
    case visitor //
}

class Square : ObservableObject {
    @Published var squareStatus : SquareStatus
    
    init(status : SquareStatus) {
        self.squareStatus = status
    }
}

struct SquareView : View {
    @ObservedObject var dataSource : Square  // holds the status of square
    var action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(self.dataSource.squareStatus == .home ?
                    "X" : self.dataSource.squareStatus == .visitor ? "0" : " ")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(maxWidth: 90, maxHeight: 90, alignment: .center)
                .background(Color.gray.opacity(0.3).cornerRadius(10))
                .padding(4)
        })
    }
}

