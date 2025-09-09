//
//  ContentView.swift
//  SwiftUITicTacToe
//
//  Created by Angelos Staboulis on 9/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var board: [String] = Array(repeating: "", count: 9)
       @State private var currentPlayer = "X"
       @State private var gameOver = false
       @State private var winner: String?

       let winningCombinations = [
           [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
           [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
           [0, 4, 8], [2, 4, 6]             // Diagonals
       ]
    var body: some View {
        VStack(spacing: 20) {
                   Text("Tic Tac Toe")
                       .font(.largeTitle)
                       .bold()

                   LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                       ForEach(0..<9, id: \.self) { index in
                           ZStack {
                               Rectangle()
                                   .foregroundColor(.blue.opacity(0.2))
                                   .frame(width: 100, height: 100)
                                   .cornerRadius(10)
                               Text(board[index])
                                   .font(.system(size: 50))
                                   .bold()
                           }
                           .onTapGesture {
                               playerMove(at: index)
                           }
                       }
                   }

                   if gameOver {
                       Text(winnerText())
                           .font(.title2)
                           .foregroundColor(.green)
                           .padding(.top)

                       Button("Play Again") {
                           resetGame()
                       }
                       .padding(.top)
                   } else {
                       Text("Current Player: \(currentPlayer)")
                           .font(.headline)
                           .padding(.top)
                   }
               }
               .padding()
    }
    func playerMove(at index: Int) {
        guard board[index] == "", !gameOver else { return }
        board[index] = currentPlayer
        checkForWinner()
        if !gameOver {
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
        }
    }

    func checkForWinner() {
        for combo in winningCombinations {
            let first = combo[0]
            let second = combo[1]
            let third = combo[2]

            if board[first] != "",
               board[first] == board[second],
               board[second] == board[third] {
                winner = board[first]
                gameOver = true
                return
            }
        }

        if !board.contains("") {
            winner = nil // Tie
            gameOver = true
        }
    }

    func winnerText() -> String {
        if let winner = winner {
            return "\(winner) Wins!"
        } else {
            return "It's a Tie!"
        }
    }

    func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        gameOver = false
        winner = nil
    }
}

#Preview {
    ContentView()
}
