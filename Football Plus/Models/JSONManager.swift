//
//  Decoder.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 08.08.2020.
//

import Foundation

struct JSONManager {
    func getData(forName name: String) -> [[String]]? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(JSONData.self, from: jsonData)
                return decodedData.array
            }
        } catch {
            print(error)
            
        }
        return nil
    }
}

