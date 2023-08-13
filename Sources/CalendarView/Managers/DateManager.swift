//
//  RKDateManager.swift
//

import SwiftUI

struct DateManager {
    
    var date: Date
    let calendarManager: CalendarManager
    
    var isDisabled: Bool = false
    var isToday: Bool = false
    var isSelected: Bool = false
    var isBetweenStartAndEnd: Bool = false
    
    init(
		date: Date,
		calendarManager: CalendarManager,
		isDisabled: Bool,
		isToday: Bool,
		isSelected: Bool,
		isBetweenStartAndEnd: Bool
	) {
        self.date = date
        self.calendarManager = calendarManager
        self.isDisabled = isDisabled
        self.isToday = isToday
        self.isSelected = isSelected
        self.isBetweenStartAndEnd = isBetweenStartAndEnd
    }
    
    func getText() -> String {
		let day = date.formatDate(calendar: calendarManager.calendar)
        return day
    }
    
    func getTextColor() -> Color {
        var textColor = calendarManager.colors.textColor
        if isDisabled {
            textColor = calendarManager.colors.disabledColor
        } else if isSelected {
            textColor = calendarManager.colors.selectedColor
        } else if isToday {
            textColor = calendarManager.colors.todayColor
        } else if isBetweenStartAndEnd {
            textColor = calendarManager.colors.betweenStartAndEndColor
        }
        return textColor
    }
    
    func getBackgroundColor() -> Color {
        var backgroundColor = calendarManager.colors.textBackColor
        if isBetweenStartAndEnd {
            backgroundColor = calendarManager.colors.betweenStartAndEndBackColor
        }
        if isToday {
            backgroundColor = calendarManager.colors.todayBackColor
        }
        if isDisabled {
            backgroundColor = calendarManager.colors.disabledBackColor
        }
        if isSelected {
            backgroundColor = calendarManager.colors.selectedBackColor
        }
        return backgroundColor
    }
//    
    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium
        if isDisabled {
            fontWeight = Font.Weight.thin
        } else if isSelected {
            fontWeight = Font.Weight.heavy
        } else if isToday {
            fontWeight = Font.Weight.heavy
        } else if isBetweenStartAndEnd {
            fontWeight = Font.Weight.heavy
        }
        return fontWeight
    }
    
    }

