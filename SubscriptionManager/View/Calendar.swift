//
//  Calendar.swift
//  SubscriptionManager
//
//  Created by Артем Соловьев on 27.12.2022.
//

import SwiftUI
import SwiftUICalendar

struct Calendar: View {
    @ObservedObject var controller: CalendarController = CalendarController(orientation: .vertical)
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .center, spacing: 0) {
                Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
                    .font(.title)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<7, id: \.self) { i in
                        Text(DateFormatter().shortWeekdaySymbols[i])
                            .font(.headline)
                            .frame(width: reader.size.width / 7)
                    }
                }
                CalendarView(controller) { date in
                    GeometryReader { geometry in
                        ZStack(alignment: .center) {
                            if date.isToday {
                                Circle()
                                    .padding(4)
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .foregroundColor(.indigo)
                                Text("\(date.day)")
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            } else {
                                Text("\(date.day)")
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .font(.system(size: 10, weight: .light, design: .default))
                                    .foregroundColor(.indigo)
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                            }
                        }
                    }
                }
            }
        }
    }
}
