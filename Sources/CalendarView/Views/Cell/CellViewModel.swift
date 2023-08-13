//
//  CellViewModel.swift
//

import Foundation

class CellViewModel: ObservableObject {
	
	// MARK: --

//	@Published var rkDate: RKDateManager
	
	// MARK: --

	@Published var countries: [Country]
	
	// MARK: --

	init(
//		rkDate: RKDateManager,
	 countries: [Country]
	) {
//		self.rkDate = rkDate
		self.countries = countries
	}

}

