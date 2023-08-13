//
//  calendarManager.swift

//

import Foundation

public class CalendarManager: ObservableObject {

    @Published public var calendar = Calendar.current
    @Published public var minimumDate: Date = Date()
    @Published public var maximumDate: Date = Date()
    @Published public var disabledDates: [Date] = [Date]()
    @Published public var selectedDates: [Date] = [Date]()
    @Published public var selectedDate: Date! = nil
    @Published public var startDate: Date! = nil
    @Published public var endDate: Date! = nil
	
	@Published public var countriesVisited: [CountriesVisited]
    
    @Published public var mode: Int = 0
    
    var colors = ColorManager()
  
	public init(
		calendar: Calendar,
		minimumDate: Date,
		maximumDate: Date,
		selectedDates: [Date] = [Date](),
		countriesVisited: [CountriesVisited] = [],
		mode: Int
	) {
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.selectedDates = selectedDates
		self.countriesVisited = countriesVisited
        self.mode = mode
    }
	
	func addDates() {
		guard var currentDate = startDate else { return }
		while currentDate <= endDate {
			selectedDates.append(currentDate)
			currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
		}
	}
	
	func removeDates() {
		selectedDates.removeAll()
	}
    
    func selectedDatesContains(date: Date) -> Bool {
        if let _ = self.selectedDates.first(where: { calendar.isDate($0, inSameDayAs: date) }) {
            return true
        }
        return false
    }
    
    func selectedDatesFindIndex(date: Date) -> Int? {
        return self.selectedDates.firstIndex(where: { calendar.isDate($0, inSameDayAs: date) })
    }
    
    func disabledDatesContains(date: Date) -> Bool {
        if let _ = self.disabledDates.first(where: { calendar.isDate($0, inSameDayAs: date) }) {
            return true
        }
        return false
    }
    
    func disabledDatesFindIndex(date: Date) -> Int? {
        return self.disabledDates.firstIndex(where: { calendar.isDate($0, inSameDayAs: date) })
    }
    
}
