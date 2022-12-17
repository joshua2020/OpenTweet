//
//  Date+Extension.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import Foundation

extension Date {

    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .short
          formatter.dateFormat = format
          return formatter.string(from: self)
      }
}
