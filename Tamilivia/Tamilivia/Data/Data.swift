//
//  Data.swift
//  Tamilivia
//
//  Created by KAVIN JAYAKUMAR stu on 30/10/23.
//

import Foundation

class DataManager {
    func fetchData(completion: @escaping ([Thirukkural]) -> Void) {
        guard let url = Bundle.main.url(forResource: "thirukkural", withExtension: "json") else {
            print("Failed to find JSON file")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let jsonData = data else {
                print("No data found")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Thirukkural].self, from: jsonData)
                completion(decodedData)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion([])
            }
        }.resume()
    }
}

struct Thirukkural: Codable {
    let adigaaram_no: Int
    let adigaaram_name_ta: String
    let adigaaram_name_en: String
    let adigaaram_name_te: String
    let iyal_no: Int
    let iyal_ta: String
    let iyal_en: String
    let iyal_te: String
    let kural_no: Int
    let kural_ta: String
    let kural_en: String
    let kural_te: String
    let mu_va_urai_ta: String
    let sa_pa_urai_ta: String
    let mu_va_urai_en: String
    let paal_no: Int
    let paal_ta: String
    let paal_en: String
    let paal_te: String
}

struct Pazhamozhi: Codable {
    
}

struct BookPhrase: Codable {
    
}

struct Sorporul: Codable {
    
}
