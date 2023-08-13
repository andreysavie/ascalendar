//
//  Country.swift

//
//  Created by Андрей Рыбалкин on 31.07.2023.
//

import Foundation

public struct Country: Codable {

	public var name: String
	public var flag: String
	
	public init(
		name: String,
		flag: String
	) {
		self.name = name
		self.flag = flag
	}
	
	enum CodingKeys: CodingKey {
		case name
		case flag
	}
	
	public init(from decoder: Decoder) throws {
		let container: KeyedDecodingContainer<Country.CodingKeys> = try decoder.container(keyedBy: Country.CodingKeys.self)
		
		self.name = try container.decode(String.self, forKey: Country.CodingKeys.name)
		self.flag = try container.decode(String.self, forKey: Country.CodingKeys.flag)
		
	}
	
	public func encode(to encoder: Encoder) throws {
		var container: KeyedEncodingContainer<Country.CodingKeys> = encoder.container(keyedBy: Country.CodingKeys.self)
		
		try container.encode(self.name, forKey: Country.CodingKeys.name)
		try container.encode(self.flag, forKey: Country.CodingKeys.flag)
	}

	
}

