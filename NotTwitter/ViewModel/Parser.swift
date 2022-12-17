//
//  Parser.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import Foundation

struct Parser {
    
    func parseJson(comp: @escaping ([Timeline]) ->()) {
        guard let path = Bundle.main.path(forResource: "tweets",
                                          ofType: "json") else
        { return }

        let url = URL(fileURLWithPath: path)

        do {
            let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
            let jsonData = try Data(contentsOf: url)
            let result = try decoder.decode(Timelines.self, from: jsonData)
            comp(result.timeline)
        }
        catch {
            print("Error: \(error)")
        }
    }
}
