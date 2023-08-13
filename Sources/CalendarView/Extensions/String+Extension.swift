//
//  Date+Extension.swift
//
//  Created by Андрей Рыбалкин on 31.07.2023.
//

import Foundation

extension String {
	
	func toDate() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		dateFormatter.timeZone = TimeZone(identifier: "GMT")
		return dateFormatter.date(from: self)
	}
	
}

