//
//  String+Extension.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import Foundation
import UIKit

extension String {

    func getStringToDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US")
        let formattedDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let date = formattedDate {
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
