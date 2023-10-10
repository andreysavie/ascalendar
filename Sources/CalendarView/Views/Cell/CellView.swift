//
//  CellView.swift
//

import SwiftUI

struct CellView: View {
	
	func flagpediaURLAPI(id: String?) -> URL? {
		guard let id else { return nil }
		let fpurl = "https://flagcdn.com/w160/\(id).jpg"
		guard let result = URL(string: fpurl) else {
			return nil
		}
		return result
	}
    	
	// MARK: --

	let dateManager: DateManager
	
	// MARK: --

	let countries: [String]
	
	@ViewBuilder func getFlagImage(
		id: String?,
		width: CGFloat,
		height: CGFloat
	) -> some View {
		
		AsyncImage(url: flagpediaURLAPI(id: id)) { image in
			image
				.image?
				.resizable()
				.frame(width: width, height: height)
		}

	}
		
	// MARK: - ViewBuilder var
	
	@ViewBuilder private var mainView: some View {
		
		VStack(spacing: 2) {
			
			Rectangle()
				.frame(height: 0.75)
				.foregroundColor(.gray)
				.padding(.bottom, 8)
			
			Text(dateManager.getText())
				.font(.system(size: 16))
				.offset(y: 4)
			
			HStack(spacing: 0) {
				
				Spacer()
				
				if countries.isEmpty {
					Spacer()
					
				} else if countries.count == 1 {
					getFlagImage(id: countries[0], width: 20, height: 14)

				} else if countries.count == 2 {
					ForEach(countries, id: \.self) { country in
						getFlagImage(id: country, width: 12, height: 10)

					}
				} else {
					ForEach(countries.prefix(2), id: \.self) { country in
						getFlagImage(id: country, width: 12, height: 10)

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
			.background {
				Circle()
					.foregroundColor(dateManager.getBackgroundColor())
					.padding(.top, 2)
			}
	}
	
}


struct CellView_Preview: PreviewProvider {
	static var previews: some View {
			CellView(dateManager: .init(date: Date(), calendarManager: .init(calendar: .current, minimumDate: Date(), maximumDate: Date(), mode: 1), isDisabled: false, isToday: true, isSelected: false, isBetweenStartAndEnd: true), countries: [])
			.frame(width: 50)
	}
}
