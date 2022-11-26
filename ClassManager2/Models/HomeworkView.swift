import SwiftUI

struct HomeworkView: View {
    @State var assignmentList: [Assignment]
    @State var isModal: Bool = false
    @State private var date = Date()
    @State private var navigate = false

    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .navigationTitle("Assignments")
            .onChange(of: date) {
                newValue in navigate = true
            }
        
            List {
                Text("Next Upcoming Assignment")
                HomeworkCard(test: getUpcoming())
                    .listRowBackground(getUpcoming().theme.mainColor)
            }
            
            NavigationLink(isActive: $navigate) {
                AddForm(assignmentList: $assignmentList, isPresented: $isModal, date: $date)
            } label: {
                EmptyView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func getUpcoming() -> Assignment {
        let upcomingHW = upcomingAssignment()
        return upcomingHW
    }
    
}


