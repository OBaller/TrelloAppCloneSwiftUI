//
//  Card.swift
//  TrelloAppClone
//
//  Created by naseem on 20/12/2021.
//

import Foundation

class Card: ObservableObject, Identifiable {
    private(set) var id = UUID()
    var boardListId: UUID
    
    @Published var content: String
    
    init(content: String, boardListId: UUID) {
        self.content = content
        self.boardListId = boardListId
    }
}
