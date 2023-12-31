//
//  RKColorSettings.swift

//

import SwiftUI

class ColorManager: ObservableObject {

    // foreground colors
    @Published var textColor: Color = Color.primary
    @Published var todayColor: Color = Color.white
    @Published var selectedColor: Color = Color.white
    @Published var disabledColor: Color = Color.gray
    @Published var betweenStartAndEndColor: Color = Color.white
    // background colors
    @Published var textBackColor: Color = Color.clear
	@Published var todayBackColor: Color = Color.red.opacity(0.5)
	@Published var selectedBackColor: Color = Color.blue.opacity(0.5)
    @Published var disabledBackColor: Color = Color.clear
    @Published var betweenStartAndEndBackColor: Color = Color.blue.opacity(0.25)
    // headers foreground colors
    @Published var weekdayHeaderColor: Color = Color.primary
    @Published var monthHeaderColor: Color = Color.primary
    // headers background colors
    @Published var weekdayHeaderBackColor: Color = Color.clear
    @Published var monthBackColor: Color = Color.clear

}
