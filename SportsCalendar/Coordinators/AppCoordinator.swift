import SwiftUI
import Combine

class AppCoordinator: ObservableObject {
    @Published var selectedWorkout: Workout?
    @Published var showWorkoutDetail = false
    
    func openWorkoutDetail(_ workout: Workout) {
        selectedWorkout = workout
        showWorkoutDetail = true
    }
    
    func closeWorkoutDetail() {
        selectedWorkout = nil
        showWorkoutDetail = false
    }
}

