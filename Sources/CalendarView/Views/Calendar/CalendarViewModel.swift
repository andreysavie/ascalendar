//
//  CalendarViewModel.swift
//

import Foundation

public class CalendarViewModel: ObservableObject {
	
	// MARK: --

	@Published var calendarManager: CalendarManager
	
	// MARK: --

	public init(calendarManager: CalendarManager) {
		self.calendarManager = calendarManager
	}
	
	// MARK: --

	func numberOfMonths() -> Int {
		return calendarManager.calendar.dateComponents([.month], from: calendarManager.minimumDate, to: maximumDateMonthLastDay()).month! + 1
	}
	
	// MARK: --

	private func maximumDateMonthLastDay() -> Date {
		var components = calendarManager.calendar.dateComponents([.year, .month, .day], from: calendarManager.maximumDate)
		components.month! += 1
		components.day = 0
		
		return calendarManager.calendar.date(from: components)!
	}

}
