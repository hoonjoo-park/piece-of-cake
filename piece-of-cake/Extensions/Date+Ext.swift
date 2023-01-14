//
//  Date+Ext.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/14.
//

import UIKit

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        
        return dateFormatter.string(from: self)
    }
}
