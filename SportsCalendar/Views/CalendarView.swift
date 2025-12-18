import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    @Environment(\.colorScheme) var colorScheme
    
    private let calendar = Calendar.current
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: { viewModel.changeMonth(by: -1) }) {
                        Image(systemName: "backward.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text(DateFormatter.monthYear.string(from: viewModel.currentMonthDate))
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: { viewModel.changeMonth(by: 1) }) {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                Color(colorScheme == .dark ? .white : .black)
                    .frame(height: 1)
                
                Color.clear.frame(height: 5)
                
                let weekdays = ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"]
                HStack {
                    ForEach(weekdays, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(0..<viewModel.leadingEmptyDays, id: \.self) { _ in
                        Text("").frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    ForEach(viewModel.daysInMonth, id: \.self) { date in
                        DayCell(
                            date: date,
                            isSelected: viewModel.isDateSelected(date),
                            hasEvent: viewModel.hasWorkouts(on: date),
                            isToday: viewModel.isToday(date)
                        )
                        .id(date)
                        .onTapGesture {
                            viewModel.selectedDate = date
                        }
                    }
                }
                
                Color.clear.frame(height: 5)
            }
            .background(Color.yellow.opacity(0.3)) .overlay( RoundedRectangle(cornerRadius: 0)
            .stroke(Color(colorScheme == .dark ? .white : .black), lineWidth: 1) )
            
            List(viewModel.monthHasSelectedDay() ? viewModel.getWorkoutsBySelectedDate() : []) { workout in
                HStack {
                    Text(workout.type)
                    Spacer()
                    if let startDate = DateFormatter.serverDateFormatter.date(from:  workout.startDate) {
                        Text(DateFormatter.displayTime.string(from: startDate))
                    } else {
                        Text("")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.openWorkoutDetail(workout)
                }
                .listRowBackground(Color.blue.opacity(0.4))
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .sheet(isPresented: $coordinator.showWorkoutDetail) {
            if let workout = coordinator.selectedWorkout {
                WorkoutDetailView(workout: workout)
            }
        }
        .padding()
        .background(Color.red.opacity(0.3))
    }
}
