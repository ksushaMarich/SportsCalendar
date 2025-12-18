import SwiftUI
import Combine

class CalendarViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var selectedDate: Date = Date()
    @Published var currentMonthDate: Date = Date() {
        didSet { loadWorkouts() }
    }
    
    private let calendar = Calendar(identifier: .gregorian)
    private let service: WorkoutService
    
    var daysInMonth: [Date] {
        guard let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonthDate)),
              let range = calendar.range(of: .day, in: .month, for: currentMonthDate) else { return [] }
        
        return range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth)
        }
    }
    
    var leadingEmptyDays: Int {
        guard let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonthDate)) else { return 0 }
        let weekdayOfFirst = calendar.component(.weekday, from: firstOfMonth)
        return (weekdayOfFirst - calendar.firstWeekday + 7) % 7
    }
    
    init(service: WorkoutService = MockWorkoutService.shared) {
            self.service = service
            loadWorkouts()
        }
    
    func changeMonth(by offset: Int) {
        guard let newMonth = calendar.date(byAdding: .month, value: offset, to: currentMonthDate) else { return }
        currentMonthDate = newMonth
    }
    
    func hasWorkouts(on date: Date) -> Bool {
        workouts.contains {
            guard let startDate = formattStartDate(form: $0.startDate) else { return false }
            return Calendar.current.isDate(startDate, inSameDayAs: date)
        }
    }
    
    func getWorkoutsBySelectedDate() -> [Workout] {
        workouts.filter {
            guard let startDate = formattStartDate(form: $0.startDate) else { return false }
            return Calendar.current.isDate(startDate, inSameDayAs: selectedDate)
        }
    }
    
    func formattStartDate(form startDate: String) -> Date? {
        DateFormatter.serverDateFormatter.date(from: startDate)
    }
    
    func loadWorkouts() {
        service.fetchWorkouts(for: currentMonthDate) { [weak self] data in
            DispatchQueue.main.async {
                self?.workouts = data
            }
        }
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
    
    func monthHasSelectedDay() -> Bool {
        calendar.isDate(selectedDate, equalTo: currentMonthDate, toGranularity: .month)
    }
}
