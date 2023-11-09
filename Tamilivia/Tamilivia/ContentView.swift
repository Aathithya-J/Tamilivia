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
    
    @State var searchText: String = ""
    @AppStorage("searchSelection") var searchSelection: SearchFilter = .kural_no

    var body: some View {
        NavigationSplitView {
            List {
//                MARK: For Testing, DO *NOT* REMOVE
//                ForEach(searchResults) { thirukkural in
//                    NavigationLink(destination: {
//                        Text(thirukkural.mu_va_urai_ta)
//                            .padding()
//                    }, label: {
//                        HStack(alignment: .top, spacing: 5) {
//                            Text("\(thirukkural.kural_no.description). ")
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
//                ToolbarItem(placement: .topBarLeading) {
//                    Menu("", systemImage: "line.3.horizontal.decrease.circle", content: {
//                        Picker("Filters", selection: $searchSelection) {
//                            ForEach(SearchFilter.allCases) { option in
//                                Text(option.description).tag(option.id)
//                            }
//                        }
//                        .pickerStyle(.navigationLink)
//                    })
//                }
            }
        } detail: {
            Text("Select an item")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search for \(searchSelection.description)")
        .keyboardType(.numberPad)
    }
    
    // -MARK -
    var searchResults: [Thirukkural] {
        if searchText.isEmpty {
            return thirukkurals
        } else {
            return thirukkurals.filter { thirukkural in
                let selectedOption: String
                
                switch searchSelection {
                case .adigaaram_no: selectedOption = thirukkural.adigaaram_no.description
                case .adigaaram_name_ta: selectedOption = thirukkural.adigaaram_name_ta
                case .adigaaram_name_en: selectedOption = thirukkural.adigaaram_name_en
                case .adigaaram_name_te: selectedOption = thirukkural.adigaaram_name_te
                case .iyal_no: selectedOption = thirukkural.iyal_no.description
                case .iyal_ta: selectedOption = thirukkural.iyal_ta
                case .iyal_en: selectedOption = thirukkural.iyal_en
                case .iyal_te: selectedOption = thirukkural.iyal_te
                case .kural_no: selectedOption = thirukkural.kural_no.description
                case .kural_ta: selectedOption = thirukkural.kural_ta
                case .kural_en: selectedOption = thirukkural.kural_en
                case .kural_te: selectedOption = thirukkural.kural_te
                case .mu_va_urai_ta: selectedOption = thirukkural.mu_va_urai_ta
                case .so_pa_urai_ta: selectedOption = thirukkural.so_pa_urai_ta
                case .mu_va_urai_en: selectedOption = thirukkural.mu_va_urai_en
                case .paal_no: selectedOption = thirukkural.paal_no.description
                case .paal_ta: selectedOption = thirukkural.paal_ta
                case .paal_en: selectedOption = thirukkural.paal_en
                case .paal_te: selectedOption = thirukkural.paal_te
                }
                
                return selectedOption.description.lowercased().contains(searchText.lowercased())
            }
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
    
    enum SearchFilter: String, CaseIterable, Identifiable, CustomStringConvertible {
        case adigaaram_no
        case adigaaram_name_ta
        case adigaaram_name_en
        case adigaaram_name_te
        case iyal_no
        case iyal_ta
        case iyal_en
        case iyal_te
        case kural_no
        case kural_ta
        case kural_en
        case kural_te
        case mu_va_urai_ta
        case so_pa_urai_ta
        case mu_va_urai_en
        case paal_no
        case paal_ta
        case paal_en
        case paal_te
        
        var id: Self { self }

        var description: String {
            switch self {
            case .adigaaram_no: return "Adigaarams (No.)"
            case .adigaaram_name_ta: return "Adigaarams (Tamil)"
            case .adigaaram_name_en: return "Adigaarams (English)"
            case .adigaaram_name_te: return "Adigaarams (Transliteration)"
            case .iyal_no: return "Iyals (No.)"
            case .iyal_ta: return "Iyals (Tamil)"
            case .iyal_en: return "Iyals (English)"
            case .iyal_te: return "Iyals (Transliteration)"
            case .kural_no: return "Thirukkurals (No.)"
            case .kural_ta: return "Thirukkurals (Tamil)"
            case .kural_en: return "Thirukkurals (English)"
            case .kural_te: return "Thirukkurals (Transliteration)"
            case .mu_va_urai_ta: return "M. Varatharasanar (Tamil)"
            case .so_pa_urai_ta: return "Sol. Pappaiah (Tamil)"
            case .mu_va_urai_en: return "M. Varatharasanar (English)"
            case .paal_no: return "Paals (No.)"
            case .paal_ta: return "Paals (Tamil)"
            case .paal_en: return "Paals (English)"
            case .paal_te: return "Paals (Transliteration)"
            }
        }
        
        // MARK: FOR TESTING, DO NOT REMOVE
//        var keyboardType: UIKeyboardType {
//            switch self {
//            case .adigaaram_no: return .numberPad
//            case .adigaaram_name_ta: return .default
//            case .adigaaram_name_en: return .default
//            case .adigaaram_name_te: return .default
//            case .iyal_no: return .numberPad
//            case .iyal_ta: return .default
//            case .iyal_en: return .default
//            case .iyal_te: return .
//            case .kural_no: return .
//            case .kural_ta: return .
//            case .kural_en: return .
//            case .kural_te: return .
//            case .mu_va_urai_ta: return .
//            case .so_pa_urai_ta: return .
//            case .mu_va_urai_en: return .
//            case .paal_no: return .
//            case .paal_ta: return .
//            case .paal_en: return .
//            case .paal_te: return .
//            }
//        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
