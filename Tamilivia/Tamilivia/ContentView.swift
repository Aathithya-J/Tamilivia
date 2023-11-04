//
//  ContentView.swift
//  Tamilivia
//
//  Created by KAVIN JAYAKUMAR stu on 30/10/23.
//
// MARK: DO NOT EDIT

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
//                MARK: For Testing, DO *NOT* REMOVE
//                ForEach(thirukkurals) { thirukkural in
//                    NavigationLink(destination: {
//                        Text(thirukkural.mu_va_urai_ta)
//                            .padding()
//                    }, label: {
//                        HStack(alignment: .top, spacing: 5) {
//                            Text("\(thirukkural.kural_no). ")
//                            Text("\(thirukkural.kural_ta)")
//                                .lineLimit(2)
//                                .minimumScaleFactor(0.01)
//                                .scaledToFit()
//                        }
//                    })
//                }
              
//                ForEach(pazhamozhis) { pazhamozhi in
//                    NavigationLink(destination: {
//                        Text("\(pazhamozhi.proverb_meaning)")
//                            .padding()
//                    }, label: {
//                        HStack(alignment: .top, spacing: 5) {
//                            Text("\(pazhamozhi.proverb_no). ")
//                            Text("\(pazhamozhi.proverb_ta)")
//                                .lineLimit(2)
//                        }
//                    })
//                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
