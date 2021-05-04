//
//  DayOfTheWeek.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 04.05.2021.
//

import Foundation

struct DayOfTheWeek {
    private func getDay(number: Int) -> String {
        switch number {
        case 1:
            return "Понедельник"
        case 2:
            return "Вторник"
        case 3:
            return "Среда"
        case 4:
            return "Четверг"
        case 5:
            return "Пятница"
        case 6:
            return "Суббота"
        case 7:
            return "Воскресенье"
        default:
            return "Undefined"
        }
    }
}

// MARK: - Day of the week formatter
extension DayOfTheWeek {
    func getDayOfTheWeek(fromDate: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let _ = fromDate,
           let date = formatter.date(from: fromDate!) {
            return self.getDay(number: Calendar.current.component(.weekday,
                                                                  from: date))
        }
        print("ERROR: Incorrect Date format")
        return "Monday"
    }
}
