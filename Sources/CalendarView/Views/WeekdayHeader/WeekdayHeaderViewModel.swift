//
//  WeekdayHeaderViewModel.swift
//

import Foundation

class WeekdayHeaderViewModel: ObservableObject {
	
	// MARK: --

	@Published var calendarManager: CalendarManager
		
	// MARK: --

	init(calendarManager: CalendarManager) {
		self.calendarManager = calendarManager
	}
	
	// MARK: --

	func getWeekdayHeaders() -> [String] {
		var calendar = Calendar(identifier: .gregorian)
		calendar.locale = Locale(identifier: "en_US")
		let weekdaySymbols = calendar.veryShortWeekdaySymbols
		let reorderedSymbols = Array(weekdaySymbols.dropFirst()) + [weekdaySymbols.first!]
		return reorderedSymbols.map { $0.lowercased() }
	}

}

