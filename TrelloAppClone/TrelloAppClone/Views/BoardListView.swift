//
//  BoardListView.swift
//  TrelloAppClone
//
//  Created by naseem on 21/12/2021.
//

import SwiftUI
import Introspect

struct BoardListView: View {
    @ObservedObject var board: Board
    @StateObject var boardList: BoardList
    @State var listHeight: CGFloat = 0
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack(alignment: .leading, spacing: 16) {
                headerView
                listView
                    .listStyle(.plain)
                    .frame(maxHeight: listHeight)
                
                Button(" + Add Card ") {
                    
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding(.vertical)
            .background(boardListBackgroundColor)
            .frame(width: 300)
            .cornerRadius(8)
            .foregroundColor(.black)
        } else {
            // Fallback on earlier versions
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .top) {
            Text(boardList.name)
                .font(.headline)
                .lineLimit(2)
            
            Spacer()
            
            Menu {
                Button("Rename") {
                    
                }
                
                if #available(iOS 15.0, *) {
                    Button("Delete", role: .destructive) {
                        
                    }
                } else {
                    // Fallback on earlier versions
                }
                
            } label: {
                Image(systemName: "ellipsis.circle")
                    .imageScale(.large)
            }
        }
        .padding(.horizontal)
    }
    
    private var listView: some View {
        List {
            if #available(iOS 15.0, *) {
                ForEach(boardList.cards) { card in
                    CardView(boardList: boardList, card: card)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                .listRowBackground(Color.clear)
                .introspectTableView {
                    listHeight = $0.contentSize.height
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct BoardListView_Previews: PreviewProvider {
    @StateObject static var board = Board.stub
    static var previews: some View {
        BoardListView(board: board, boardList: board.lists[0], listHeight: 512)
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 512)
    }
 }