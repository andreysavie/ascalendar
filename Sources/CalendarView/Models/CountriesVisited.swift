//
//  CountriesVisited.swift
//

import Foundation

public struct CountriesVisited: Codable {
	
	// MARK: --

	public var date: Date
	
	public var countries: [Country]
	
	// MARK: --

	public init(
		date: Date,
		countries: [Country]
	) {
		self.date = date
		self.countries = countries
	}
	
	public init (
		date: String,
		countries: [Country]
	) {
		let convertedDate = date.toDate() ?? Date()
		self.init(date: convertedDate, countries: countries)
	}
	
	// MARK: --

	public enum CodingKeys: CodingKey {
		case date
		case countries
	}
	
	// MARK: --

	public init(from decoder: Decoder) throws {
		let container: KeyedDecodingContainer<CountriesVisited.CodingKeys> = try decoder.container(keyedBy: CountriesVisited.CodingKeys.self)
		
		self.date = try container.decode(String.self, forKey: CountriesVisited.CodingKeys.date).toDate() ?? Date()
		self.countries = try container.decode([Country].self, forKey: CountriesVisited.CodingKeys.countries)
		
	}
	
	public func encode(to encoder: Encoder) throws {
		var container: KeyedEncodingContainer<CountriesVisited.CodingKeys> = encoder.container(keyedBy: CountriesVisited.CodingKeys.self)
		
		try container.encode(self.date, forKey: CountriesVisited.CodingKeys.date)
		try container.encode(self.countries, forKey: CountriesVisited.CodingKeys.countries)
	}

	
}

