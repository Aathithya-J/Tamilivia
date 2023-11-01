//
//  Data.swift
//  Tamilivia
//
//  Created by KAVIN JAYAKUMAR stu on 30/10/23.
// Test

import Foundation

// TODO: NEED TO MAKE DUPLICATE
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

var thirukkurals: [Thirukkural] = load("thirukkural.json")

struct Thirukkural: Identifiable, Decodable {
    var id: Int {
        return kural_no
    }
    var adigaaram_no: Int
    var adigaaram_name_ta: String
    var adigaaram_name_en: String
    var adigaaram_name_te: String
    var iyal_no: Int
    var iyal_ta: String
    var iyal_en: String
    var iyal_te: String
    var kural_no: Int
    var kural_ta: String
    var kural_en: String
    var kural_te: String
    var mu_va_urai_ta: String
    var sa_pa_urai_ta: String
    var mu_va_urai_en: String
    var paal_no: Int
    var paal_ta: String
    var paal_en: String
    var paal_te: String
}

struct Pazhamozhi: Codable {
    let proverb_no: Int
    let proverb_ta: String
    let proverb_meaning: String
    let proverb_te: String
    let proverb_explanation: String
}

enum Book: String, CaseIterable {
    case Ennangal
    case VetrikuEzhuPadigal
    case OorukkuNallathuSolven
}

struct BookPhrase {
    let phrase: String
    let book: Book
}

struct Sorporul: Codable {
    
}
