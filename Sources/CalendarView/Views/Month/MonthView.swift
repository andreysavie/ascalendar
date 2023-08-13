//
//  MonthView.swift
//

import SwiftUI

struct MonthView: View {

//	@Binding var isPresented: Bool
	
	@ObservedObject var calendarManager: CalendarManager
	
	let monthOffset: Int
	
	let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
	let daysPerWeek = 7
	var monthsArray: [[Date]] {
		monthArray()
	}
	let cellWidth = CGFloat(32)
	
	@State var showTime = false
	
	
	var body: some View {
		
		VStack(alignment: .trailing, spacing: 10){
			
			Text(getMonthHeader()).foregroundColor(self.calendarManager.colors.monthHeaderColor)
				.padding(.horizontal)
			
			VStack(alignment: .leading, spacing: 5) {
				
				ForEach(monthsArray, id:  \.self) { row in
					
					HStack() {
						
						Spacer()
						
						ForEach(row, id:  \.self) { column in
							
							HStack(spacing: 0) {
								
								if isThisMonth(date: column) {
									CellView(viewModel: .init(countries: []),
											 rkDate: DateManager(
										date: column,
										calendarManager: self.calendarManager,
										isDisabled: !self.isEnabled(date: column),
										isToday: self.isToday(date: column),
										isSelected: self.isSpecialDate(date: column),
										isBetweenStartAndEnd: self.isBetweenStartAndEnd(date: column)))
										.onTapGesture {
											self.dateTapped(date: column)
										}
									
								} else {
									
									Spacer()
									
								}
							}
						}
						
						Spacer()
					}
				}
			}
			.frame(minWidth: 0, maxWidth: .infinity)
		}
		.background(calendarManager.colors.monthBackColor)
	}

	 func isThisMonth(date: Date) -> Bool {
		 return self.calendarManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
	 }
		
	func dateTapped(date: Date) {
		if self.isEnabled(date: date) {
			switch self.calendarManager.mode {
			case 1:
				self.calendarManager.startDate = date
				self.calendarManager.endDate = nil
				self.calendarManager.mode = 2
			case 2:
				self.calendarManager.endDate = date
				if self.isStartDateAfterEndDate() {
					self.calendarManager.endDate = nil
					self.calendarManager.startDate = nil
				}
				self.calendarManager.mode = 1
			default:
				self.calendarManager.selectedDate = date
			}
		}
	}
	 
	func monthArray() -> [[Date]] {
		var rowArray = [[Date]]()
		for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
			var columnArray = [Date]()
			for column in 0 ... 6 {
				let abc = self.getDateAtIndex(index: (row * 7) + column)
				columnArray.append(abc)
			}
			rowArray.append(columnArray)
		}
		return rowArray
	}
	
	func getMonthHeader() -> String {
		let headerDateFormatter = DateFormatter()
		headerDateFormatter.calendar = calendarManager.calendar
		headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "LLLL", options: 0, locale: calendarManager.calendar.locale)
		
		return headerDateFormatter.string(from: firstOfMonthForOffset())
	}
	
	func getDateAtIndex(index: Int) -> Date {
		let firstOfMonth = firstOfMonthForOffset()
		let weekday = calendarManager.calendar.component(.weekday, from: firstOfMonth)
		var startOffset = weekday - calendarManager.calendar.firstWeekday
		startOffset += startOffset >= 0 ? 0 : daysPerWeek
		var dateComponents = DateComponents()
		dateComponents.day = index - startOffset
		
		return calendarManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
	}
	
	func numberOfDays(offset : Int) -> Int {
		let firstOfMonth = firstOfMonthForOffset()
		let rangeOfWeeks = calendarManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
		
		return (rangeOfWeeks?.count)! * daysPerWeek
	}
	
	func firstOfMonthForOffset() -> Date {
		var offset = DateComponents()
		offset.month = monthOffset
		
		return calendarManager.calendar.date(byAdding: offset, to: RKFirstDateMonth())!
	}
	
	func RKFormatDate(date: Date) -> Date {
		let components = calendarManager.calendar.dateComponents(calendarUnitYMD, from: date)
		
		return calendarManager.calendar.date(from: components)!
	}
	
	func RKFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
		let refDate = RKFormatDate(date: referenceDate)
		let clampedDate = RKFormatDate(date: date)
		return refDate == clampedDate
	}
	
	func RKFirstDateMonth() -> Date {
		var components = calendarManager.calendar.dateComponents(calendarUnitYMD, from: calendarManager.minimumDate)
		components.day = 1
		
		return calendarManager.calendar.date(from: components)!
	}
	
	// MARK: - Date Property Checkers
	
	func isToday(date: Date) -> Bool {
		return RKFormatAndCompareDate(date: date, referenceDate: Date())
	}
	 
	func isSpecialDate(date: Date) -> Bool {
		return isSelectedDate(date: date) ||
			isStartDate(date: date) ||
			isEndDate(date: date) ||
			isOneOfSelectedDates(date: date)
	}
	
	func isOneOfSelectedDates(date: Date) -> Bool {
		return self.calendarManager.selectedDatesContains(date: date)
	}

	func isSelectedDate(date: Date) -> Bool {
		if calendarManager.selectedDate == nil {
			return false
		}
		return RKFormatAndCompareDate(date: date, referenceDate: calendarManager.selectedDate)
	}
	
	func isStartDate(date: Date) -> Bool {
		if calendarManager.startDate == nil {
			return false
		}
		return RKFormatAndCompareDate(date: date, referenceDate: calendarManager.startDate)
	}
	
	func isEndDate(date: Date) -> Bool {
		if calendarManager.endDate == nil {
			return false
		}
		return RKFormatAndCompareDate(date: date, referenceDate: calendarManager.endDate)
	}
	
	func isBetweenStartAndEnd(date: Date) -> Bool {
		if calendarManager.startDate == nil {
			return false
		} else if calendarManager.endDate == nil {
			return false
		} else if calendarManager.calendar.compare(date, to: calendarManager.startDate, toGranularity: .day) == .orderedAscending {
			return false
		} else if calendarManager.calendar.compare(date, to: calendarManager.endDate, toGranularity: .day) == .orderedDescending {
			return false
		}
		return true
	}
	
	func isOneOfDisabledDates(date: Date) -> Bool {
		return self.calendarManager.disabledDatesContains(date: date)
	}
	
	func isEnabled(date: Date) -> Bool {
		let clampedDate = RKFormatDate(date: date)
		if calendarManager.calendar.compare(clampedDate, to: calendarManager.minimumDate, toGranularity: .day) == .orderedAscending || calendarManager.calendar.compare(clampedDate, to: calendarManager.maximumDate, toGranularity: .day) == .orderedDescending {
			return false
		}
		return !isOneOfDisabledDates(date: date)
	}
	
	func isStartDateAfterEndDate() -> Bool {
		if calendarManager.startDate == nil {
			return false
		} else if calendarManager.endDate == nil {
			return false
		} else if calendarManager.calendar.compare(calendarManager.endDate, to: calendarManager.startDate, toGranularity: .day) == .orderedDescending {
			return false
		}
		return true
	}
}

//#if DEBUG
//struct RKMonth_Previews : PreviewProvider {
//	static var previews: some View {
//		RKMonth(isPresented: .constant(false),calendarManager: calendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), monthOffset: 0)
//	}
//}
//#endif



//struct MonthView: View {
//
//	// MARK: --
//
//	@StateObject private var viewModel: MonthViewModel
//
//	// MARK: --
//
//	init(viewModel: MonthViewModel) {
//		self._viewModel = StateObject(wrappedValue: viewModel)
//	}
//
//    var body: some View {
//
//        VStack(alignment: .trailing, spacing: 10) {
//
//			Text(viewModel.getMonthHeader()).foregroundColor(viewModel.calendarManager.colors.monthHeaderColor)
//				.bold()
//				.padding(.trailing)
//
//			VStack(alignment: .leading, spacing: 5) {
//
//				ForEach(viewModel.monthsArray, id:  \.self) { row in
//
//					HStack() {
//
//						Spacer()
//
//						ForEach(row, id:  \.self) { column in
//
//							HStack(spacing: 0) {
//
//                                if viewModel.isThisMonth(date: column) {
//
//									CellView(viewModel: .init(
//
//										rkDate: RKDateManager(
//											date:  column,
//											calendarManager: viewModel.calendarManager,
//											isDisabled: viewModel.isEnabled(date: column),
//											isToday: viewModel.isToday(date: column),
//											isSelected: viewModel.isSpecialDate(date: column),
//											isBetweenStartAndEnd: viewModel.isBetweenStartAndEnd(date: column)),
//										countries: viewModel.getCountries(for: column)
//									))
//                                        .onTapGesture {
//											print(column)
//											viewModel.dateTapped(date: column)
//										}
//
//                                } else {
//
//									Spacer()
//
//								}
//                            }
//                        }
//
//						Spacer()
//                    }
//                }
//            }
//			.frame(minWidth: 0, maxWidth: .infinity)
//        }
//		.background(viewModel.calendarManager.colors.monthBackColor)
//    }
//
//}
//
//struct RKMonth_Previews : PreviewProvider {
//    static var previews: some View {
//
//		let mock = MockDataService()
//
//		var calendarManager: calendarManager = {
//
//			let calendar = Calendar.current
//			let components = calendar.dateComponents([.year], from: Date())
//			let startOfYear = calendar.date(from: components)!
//			let endOfYear = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startOfYear)!
//
//			let calendarManager = calendarManager(
//				calendar: calendar,
//				minimumDate: startOfYear,
//				maximumDate: endOfYear,
//				countriesVisited: mock.countriesVisited,
//				mode: 2
//			)
//
//			return calendarManager
//		}()
//
//		MonthView(
//			viewModel: .init(
//				calendarManager: calendarManager,
//				monthOffset: 0)
//		)
//	}
//}
