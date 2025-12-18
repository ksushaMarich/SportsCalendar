import Foundation

struct MockResponse: Codable {
    let data: [Workout]
}

protocol WorkoutService {
    func fetchWorkouts(for month: Date, completion: @escaping ([Workout]) -> Void)
}

class MockWorkoutService {
    static let shared = MockWorkoutService()
    
    private init() {}
}

extension MockWorkoutService: WorkoutService {
    func fetchWorkouts(for month: Date ,completion: @escaping ([Workout]) -> Void) {
        guard let url = Bundle.main.url(forResource: "workouts", withExtension: "json") else {
            completion([])
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.serverDateFormatter)
            let response = try decoder.decode(MockResponse.self, from: data)
            let calendar = Calendar.current
            let filteredWorkouts = response.data.filter { workout in
                guard let date = DateFormatter.serverDateFormatter.date(from: workout.startDate) else { return false }
                return calendar.isDate(date, equalTo: month, toGranularity: .month)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                completion(filteredWorkouts)
            }
        } catch {
            print(error)
            completion([])
        }
    }
}
