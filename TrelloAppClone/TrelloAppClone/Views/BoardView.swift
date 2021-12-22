//
//  BoardView.swift
//  TrelloAppClone
//
//  Created by naseem on 21/12/2021.
//

import SwiftUI

let boardListBackgroundColor = Color(uiColor: UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1))
let trelloBlueBackgroundColor = Color(uiColor: UIColor(red: 0.2, green: 0.47, blue: 0.73, alpha: 1))

struct BoardView: View {
        @StateObject private var board: Board = Board.stub
    var body: some View {
        NavigationView {
                ScrollView(.horizontal){
                    LazyHStack(alignment: .top, spacing: 24) {
                        ForEach(board.lists) { boardList in
                            BoardListView(board: board, boardList: boardList)
                                .onDrop(of: [Card.typeIdentifier], delegate: BoardDropDelegate(board: board, boardList: boardList))
                        }
                        Button("+ Add List "){
                            handleOnAddList()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(boardListBackgroundColor.opacity(0.8))
                        .frame(width: 300)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    }
                    .padding()
                    
                }
//                .background(trelloBlueBackgroundColor)
                .background(Image("applehq1")
                                .resizable())
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle(board.name, displayMode: .inline)
        }
        .navigationViewStyle(.stack )
    }
    
    func handleOnAddList() {
        presentAlertTextField(title: "Add list") { text in
            guard let text = text, !text.isEmpty else {
                return
            }
            board.addNewBoardListWithName(text)

        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
            BoardView()
                .previewInterfaceOrientation(.landscapeLeft)
    }
}
