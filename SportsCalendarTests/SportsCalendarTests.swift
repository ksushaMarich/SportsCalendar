import XCTest
@testable import SportsCalendar

// MARK: - Mock Service

final class WorkoutServiceMock: WorkoutService {
    var workouts: [Workout] = []

    func fetchWorkouts(for month: Date, completion: @escaping ([Workout]) -> Void) {
        completion(workouts)
    }
}

// MARK: - Tests

final class CalendarViewModelTests: XCTestCase {

    private var service: WorkoutServiceMock!
    private var viewModel: CalendarViewModel!
    private let calendar = Calendar(identifier: .gregorian)

    override func setUp() {
        super.setUp()
        service = WorkoutServiceMock()
        viewModel = CalendarViewModel(service: service)
    }

    override func tearDown() {
        service = nil
        viewModel = nil
        super.tearDown()
    }

    // MARK: - formattStartDate()

    func test_formattStartDate_validString_returnsDate() {
        let dateString = "2025-11-25 09:30:00"

        let date = viewModel.formattStartDate(form: dateString)

        XCTAssertNotNil(date)
    }

    func test_formattStartDate_validString_returnsCorrectComponents() {
        let dateString = "2025-11-25 09:30:00"

        let date = viewModel.formattStartDate(form: dateString)!
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.day, 25)
    }

    func test_formattStartDate_invalidString_returnsNil() {
        let date = viewModel.formattStartDate(form: "wrong-format")

        XCTAssertNil(date)
    }

    // MARK: - changeMonth()

    func test_changeMonth_forward() {
        let initialDate = DateComponents(
            calendar: calendar,
            year: 2025,
            month: 5,
            day: 1
        ).date!

        viewModel.currentMonthDate = initialDate
        viewModel.changeMonth(by: 1)

        let components = calendar.dateComponents(
            [.year, .month],
            from: viewModel.currentMonthDate
        )

        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 6)
    }

    func test_changeMonth_backward() {
        let initialDate = DateComponents(
            calendar: calendar,
            year: 2025,
            month: 5,
            day: 1
        ).date!

        viewModel.currentMonthDate = initialDate
        viewModel.changeMonth(by: -1)

        let components = calendar.dateComponents(
            [.year, .month],
            from: viewModel.currentMonthDate
        )

        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 4)
    }

    // MARK: - getWorkoutsBySelectedDate()

    func test_getWorkoutsBySelectedDate_filtersCorrectly() {
        let workout1 = Workout(
            id: UUID().uuidString,
            type: "Run",
            startDate: "2025-11-25 09:30:00"
        )

        let workout2 = Workout(
            id: UUID().uuidString,
            type: "Yoga",
            startDate: "2025-11-26 10:00:00"
        )

        viewModel.workouts = [workout1, workout2]

        viewModel.selectedDate = calendar.date(
            from: DateComponents(
                calendar: calendar,
                year: 2025,
                month: 11,
                day: 25
            )
        )!

        let result = viewModel.getWorkoutsBySelectedDate()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.type, "Run")
    }
}
