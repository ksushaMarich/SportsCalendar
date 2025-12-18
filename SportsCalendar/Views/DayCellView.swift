import Foundation
import SwiftUI

struct DayCell: View {
    let date: Date
    let isSelected: Bool
    let hasEvent: Bool
    let isToday: Bool
    
    var body: some View {
        VStack {
            Text("\(Calendar.current.component(.day, from: date))")
                .foregroundColor(isSelected ? .white : .primary)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.blue : Color.clear)
                        .overlay(Circle().stroke(isToday ? Color.red : .clear, lineWidth: 2))
                )
            Circle()
                .fill(hasEvent ? .red : .clear)
                .frame(width: 6, height: 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
