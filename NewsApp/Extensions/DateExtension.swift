//
//  DateExtension.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
