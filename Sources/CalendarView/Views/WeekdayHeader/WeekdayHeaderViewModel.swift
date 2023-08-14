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
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
		let weekdaySymbols = formatter.veryShortWeekdaySymbols
		return weekdaySymbols?.compactMap { $0.lowercased() } ?? []
	}

}

