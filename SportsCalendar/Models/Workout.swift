import Foundation

struct Workout: Identifiable, Codable {
    let id: String
    let type: String
    let startDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "workoutKey"
        case type = "workoutActivityType"
        case startDate = "workoutStartDate"
    }
    
    var image: String {
        switch type {
        case "Walking/Running":
            return "figure.run"
        case "Water":
            return "figure.pool.swim"
        case "Cycling":
            return "bicycle"
        case "Yoga":
            return "figure.yoga"
        case "Strength":
            return "figure.strengthtraining.traditional"
        default:
            return "figure.run"
        }
    }
}

