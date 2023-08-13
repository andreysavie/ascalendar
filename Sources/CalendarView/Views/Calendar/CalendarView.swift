//
//  ASCalendarView.swift
//

import SwiftUI

public struct ASCalendarView: View {
    
	// MARK: --

    @Binding public var isPresented: Bool
	
	// MARK: --

	@StateObject private var viewModel: CalendarViewModel
	
	// MARK: --

	public init(
		isPresented: Binding<Bool>,
		viewModel: CalendarViewModel
	) {
		self._isPresented = isPresented
		self._viewModel = StateObject(wrappedValue: viewModel)
	}
    	
	// MARK: --

	public var body: some View {
		Group {
			WeekdayHeaderView(viewModel: .init(calendarManager: viewModel.calendarManager))
				.padding(.vertical, 2)
				.background {
					Color(red: 0.922, green: 0.922, blue: 0.922, opacity: 1.0)
				}
			
			Divider()
			
			ScrollView(.vertical, showsIndicators: false) {
				
				VStack {
					
					ForEach(0..<viewModel.numberOfMonths(), id: \.self) { index in
						
						MonthView(calendarManager: viewModel.calendarManager, monthOffset: index)
					}
					
					Divider()
					
				}
			}
		}
	}
    
}

//struct RKViewController_Previews : PreviewProvider {
//	static var previews: some View {
//
//		let calendar = Calendar.current
//		let components = calendar.dateComponents([.year], from: Date())
//		let startOfYear = calendar.date(from: components)!
//		let endOfYear = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startOfYear)!
//		let service = MockDataService()
//		let calendarManager = calendarManager(
//			calendar: calendar,
//			minimumDate: startOfYear,
//			maximumDate: endOfYear,
//			countriesVisited: service.countriesVisited,
//			mode: 0)
//
//		VStack {
//			CalendarView(isPresented: .constant(false), viewModel: .init(calendarManager: calendarManager(calendar: calendar, minimumDate: startOfYear, maximumDate: endOfYear, mode: 0)))
//		}
//	}
//}
