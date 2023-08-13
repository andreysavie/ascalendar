//
//  CellView.swift
//

import SwiftUI

struct CellView: View {
    
	// MARK: --
    	
	@StateObject private var viewModel: CellViewModel
	
	var rkDate: DateManager
	
	// MARK: --
	
	init(
		viewModel: CellViewModel,
		rkDate: DateManager
	) {
		self._viewModel = StateObject(wrappedValue: viewModel)
		self.rkDate = rkDate
	}
	
	// MARK: - ViewBuilder var
	
	@ViewBuilder private var mainView: some View {
		
		VStack(spacing: 2) {
			
			Rectangle()
				.frame(height: 0.75)
				.foregroundColor(.gray)
				.padding(.bottom, 8)
			
			Text(rkDate.getText())
				.font(.system(size: 16))
			
			HStack(spacing: 0) {
				
				Spacer()
				
				if viewModel.countries.isEmpty {
					Spacer()
				} else if viewModel.countries.count == 1 {
					Image(viewModel.countries[0].flag)
						.resizable()
						.frame(width: 20, height: 14)
				} else if viewModel.countries.count == 2 {
					ForEach(viewModel.countries, id: \.flag) { country in
						Image(country.flag)
							.resizable()
							.frame(width: 12, height: 10)
					}
				} else {
					ForEach(viewModel.countries.prefix(2), id: \.flag) { country in
						Image(country.flag)
							.resizable()
							.frame(width: 12, height: 10)
					}
					Circle()
						.frame(width: 4, height: 4)
						.foregroundColor(.blue)
						.padding(2)
				}
				
				Spacer()
			}
			.frame(height: 15)
			
		}
	}
	
	// MARK: - body
	
	var body: some View {
		mainView
			.background(rkDate.getBackgroundColor().opacity(0.25))
	}
}

//struct RKCell_Previews : PreviewProvider {
//	static var previews: some View {
//		HStack {
//			RKCell(viewModel: .init(
//				rkDate: RKDate(
//					date: Date(),
//					calendarManager: calendarManager(
//						calendar: Calendar.current,
//						minimumDate: Date(),
//						maximumDate: Date().addingTimeInterval(60*60*24*365),
//						mode: 0
//					),
//					isDisabled: false,
//					isToday: false,
//					isSelected: false,
//					isBetweenStartAndEnd: false
//				),
//				countries: []
//			))
//			.previewDisplayName("Control")
//		}
//		.previewLayout(.fixed(width: 300, height: 70))
//		.environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
//	}
//}
