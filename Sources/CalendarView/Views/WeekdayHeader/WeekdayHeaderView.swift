//
//  WeekdayHeader.swift
//

import SwiftUI

struct WeekdayHeaderView: View {
	
	@StateObject private var viewModel: WeekdayHeaderViewModel
	
	// MARK: --
	
	init(viewModel: WeekdayHeaderViewModel) {
		self._viewModel = StateObject(wrappedValue: viewModel)
	}

	
	var body: some View {
		
		HStack(alignment: .center) {
			
			ForEach(viewModel.getWeekdayHeaders(), id: \.self) { weekday in
				
				Text(weekday)
					.font(.system(size: 20))
					.frame(minWidth: 0, maxWidth: .infinity)
					.foregroundColor(viewModel.calendarManager.colors.weekdayHeaderColor)
			}
		}
		.background(viewModel.calendarManager.colors.weekdayHeaderBackColor)
	}
	
}
