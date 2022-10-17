import Foundation

struct Assignment: Identifiable & Hashable & Equatable {
    let id: UUID
    var name: String
    var dueYear: Int
    var dueMonth: Int
    var dueDay: Int
    var theme: Theme
    var className: String
    var monthDay: Int
    
    init(id: UUID = UUID(), name: String, dueYear: Int, dueMonth: Int, dueDay: Int, theme: Theme, className: String) {
        self.id = id
        self.name = name
        self.dueYear = dueYear
        self.dueMonth = dueMonth
        self.dueDay = dueDay
        self.theme = theme
        self.className = className
        self.monthDay = ((String(dueMonth) + String(format: "%02d", dueDay)) as NSString).integerValue
    }
    
    static func == (lhs: Assignment, rhs: Assignment) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Assignment {
    static var sampleData: [Assignment] =
    [
        Assignment(name: "Project 1", dueYear: 2022, dueMonth: 10, dueDay: 21, theme: .poppy, className: "Math"),
        Assignment(name: "Project 2", dueYear: 2022, dueMonth: 10, dueDay: 20, theme: .bubblegum, className: "Science"),
        Assignment(name: "Homework 2", dueYear: 2022, dueMonth: 10, dueDay: 22, theme: .bubblegum, className: "Science"),
        Assignment(name: "English Literature Paper", dueYear: 2022, dueMonth: 10, dueDay: 23, theme: .yellow, className: "English"),
        Assignment(name: "Homework 3", dueYear: 2022, dueMonth: 10, dueDay: 23, theme: .poppy, className: "Science"),
        Assignment(name: "Project 3", dueYear: 2022, dueMonth: 11, dueDay: 14, theme: .sky, className: "Science"),
        Assignment(name: "Midterm", dueYear: 2022, dueMonth: 10, dueDay: 28, theme: .yellow, className: "English"),
        Assignment(name: "Science Final", dueYear: 2022, dueMonth: 12, dueDay: 10, theme: .orange, className: "Science"),
        Assignment(name: "Math Final", dueYear: 2022, dueMonth: 12, dueDay: 08, theme: .bubblegum, className: "Math")
    ]
}

func upcomingAssignment() -> Assignment {
    Assignment.sampleData.sort(by: { (lhs, rhs) -> Bool in
        lhs.monthDay < rhs.monthDay
    })
    return Assignment.sampleData[0]
}

func assignmentsOnDate(_dueYear: Int, _dueMonth: Int, _dueDay: Int) -> [Assignment] {
    var assignmentsToday = [Assignment]()

    (Assignment.sampleData).forEach { HW in
        if (_dueYear == HW.dueYear && _dueMonth == HW.dueMonth && _dueDay == HW.dueDay) {
            assignmentsToday.append(HW)
        }
    }
    return assignmentsToday
}
