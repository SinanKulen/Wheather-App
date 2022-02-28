//
//  Int+.swift
//  Wheather App
//
//  Created by Sinan Kulen on 23.02.2022.
//

import Foundation

extension Int
{
    func convertToString()->String
    {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
    func convertToHourString() -> String
    {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:00"
        return dateFormatter.string(from: date)
    }
}
