import SwiftUI

@main
struct SportsCalendarApp: App {

    @StateObject private var coordinator = AppCoordinator()
    
    @StateObject private var calendarViewModel = CalendarViewModel()
    
    var body: some Scene {
        WindowGroup {
            CalendarView(viewModel: calendarViewModel)
                .environmentObject(coordinator)
        }
    }
}
