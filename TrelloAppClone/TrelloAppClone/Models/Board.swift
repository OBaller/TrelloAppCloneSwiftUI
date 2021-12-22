//
//  Board.swift
//  TrelloAppClone
//
//  Created by naseem on 20/12/2021.
//

import Foundation

class Board: ObservableObject, Identifiable {
    private(set) var id = UUID()
    @Published var name: String
    @Published var lists: [BoardList]
    
    init(name: String, lists: [BoardList] = []) {
        self.name = name
        self.lists = lists
    }
    
    func move(card: Card, to boardList: BoardList, at index: Int) {
        guard
            let sourceBoardListIndex = boardListIndext(id: card.boardListId),
            let destinationBoardListIndex = boardListIndext(id: boardList.id),
            sourceBoardListIndex != destinationBoardListIndex,
                let sourceCardIndex = cardIndex(id: card.id, boardIndex: sourceBoardListIndex) else { return }
        boardList.cards.insert(card, at: index)
        card.boardListId = boardList.id
        lists[sourceBoardListIndex].cards.remove(at: sourceCardIndex)
    }
    
    func addNewBoardListWithName(_ name: String) {
        lists.append(BoardList(name: name, boardID: id))
    }
    
    func removeBoardList(_ boardlist: BoardList) {
        guard let index = boardListIndext(id: boardlist.id) else { return }
        lists.remove(at: index)
    }
    
    private func cardIndex(id: UUID, boardIndex: Int) -> Int? {
        lists[boardIndex].cardIndex(id: id)
    }
    
    private func boardListIndext(id: UUID) -> Int? {
        lists.firstIndex { $0.id == id }
    }
}
