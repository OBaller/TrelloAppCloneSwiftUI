//
//  Board+Stub.swift
//  TrelloAppClone
//
//  Created by naseem on 20/12/2021.
//

import Foundation

extension Board {
    static var stub: Board {
        let board = Board(name: "NAS Board 🗓")
        let backlogBoardList = BoardList(name: "Backlog", boardID: board.id)
        let backlogCards = [
                "Cloud Service",
                "Cloud Computing",
                "Network Service",
                "Grand Central Dispatch",
                "DB Service",
                "Scheme Design",
                "Web Analytics and CMS",
                "Data Persistence"
        ].map { Card(content: $0, boardListId: backlogBoardList.id ) }
        backlogBoardList.cards = backlogCards
        
        let todoBoardList = BoardList(name: "ToDo", boardID: board.id)
        let todoCards = [
                "Error Handling",
                "Text Search"
        ].map { Card(content: $0, boardListId: todoBoardList.id ) }
        todoBoardList.cards = todoCards
        
        let inProgressBoardList = BoardList(name: "In Progress", boardID: board.id)
        let inProgressCards = ["File Storage"].map { Card(content: $0, boardListId: inProgressBoardList.id ) }
        inProgressBoardList.cards = inProgressCards
        
        let doneBoardList = BoardList(name: "Done", boardID: board.id)
        board.lists = [
            backlogBoardList,
            todoBoardList,
            inProgressBoardList,
            doneBoardList
        ]
        return board
    }
}
