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
    @StateObject private var board: Board = BoardDiskRepository().loadFromDisk() ?? Board.stub
        @State private var dragging: BoardList?
    var body: some View {
        NavigationView {
                ScrollView(.horizontal){
                    LazyHStack(alignment: .top, spacing: 24) {
                        ForEach(board.lists) { boardList in
                            BoardListView(board: board, boardList: boardList)
                                .onDrag({
                                    self.dragging = boardList
                                    return NSItemProvider(object: boardList)
                                })
                                .onDrop(of: [Card.typeIdentifier, BoardList.typeIdentifier], delegate: BoardDropDelegate(board: board, boardList: boardList, lists: $board.lists, current: $dragging))
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
                    .animation(.default, value: board.lists)
                    
                }
//                .background(trelloBlueBackgroundColor)
                .background(Image("applehq1")
                                .resizable())
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle(board.name, displayMode: .inline)
                .toolbar {
                    Button("Rename") {
                        handleRenameBoard()
                    }
                }
        }
        .navigationViewStyle(.stack )
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            BoardDiskRepository().saveToDisk(board: board)
        }
    }
    
    func handleOnAddList() {
        presentAlertTextField(title: "Add list") { text in
            guard let text = text, !text.isEmpty else {
                return
            }
            board.addNewBoardListWithName(text)

        }
    }
    
    private func handleRenameBoard() {
        presentAlertTextField(title: "Rename Board", defaultTextFieldText: board.name) { text in
            guard let text = text, !text.isEmpty else {
                return
            }
            board.name = text
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
            BoardView()
                .previewInterfaceOrientation(.landscapeLeft)
    }
}
