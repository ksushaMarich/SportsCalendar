import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                Text(workout.type)
                    .font(.title)
                if let startDate = DateFormatter.serverDateFormatter.date(from:  workout.startDate) {
                    Text("Дата: \(DateFormatter.fullDate.string(from: startDate))")
                } else {
                    Text("")
                }
            }

            Spacer()

            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200) 
                .foregroundColor(.blue.opacity(0.7))

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.brown.opacity(0.3))
        .ignoresSafeArea()
    }
}

extension DateFormatter {
    static let fullDate: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy, HH:mm"
        return f
    }()
}


