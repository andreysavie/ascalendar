//
//  Date+Extension.swift

//
//  Created by Андрей Рыбалкин on 31.07.2023.
//

import Foundation

extension Date {
	
	func iso8601StringFromDate() -> String {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withFullDate]
		return dateFormatter.string(from: self)
	}
	
	func truncateTime() -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		dateFormatter.timeZone = TimeZone(identifier: "GMT")
		
		let dateString = dateFormatter.string(from: self)
		return dateFormatter.date(from: dateString)!
	}
	
	func formatDate(calendar: Calendar) -> String {
		let formatter = dateFormatter()
		return stringFrom(formatter: formatter, calendar: calendar)
	}
	
	func dateFormatter() -> DateFormatter {
		let formatter = DateFormatter()
		formatter.locale = .current
		formatter.dateFormat = "d"
		return formatter
	}
	
	func stringFrom(formatter: DateFormatter, calendar: Calendar) -> String {
		if formatter.calendar != calendar {
			formatter.calendar = calendar
		}
		return formatter.string(from: self)
	}
	
	func monthNumber() -> Int {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.month], from: self)
		if let month = components.month {
			return month
		} else {
			return 0 // Если не удалось получить номер месяца
		}
	}

	
}
