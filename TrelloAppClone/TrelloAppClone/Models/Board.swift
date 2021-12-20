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
}
