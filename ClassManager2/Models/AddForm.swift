
import Foundation
import SwiftUI

struct AddForm: View {
    @Binding var assignmentList: [Assignment]
    @Binding var isPresented: Bool
    @Binding var date: Date
    @State private var _className: String = ""
    @State private var _assignmentName: String = ""
    @State private var _dueMonth: String = ""
    @State private var _dueDay: String = ""
    @State private var _dueYear: String = ""
    @State var editMode = EditMode.inactive
    @State var selection = Set<Assignment>()
    @Environment(\.presentationMode) var presentationMode
    @State var selectedClass = "Math"
    
    var body: some View {
        VStack {
            Text("Assignments Due on " + getDate())
                .font(.system(size: 22))
                .background(.white)
            if (checkEmpty()) {
                Text("No assignments due today!")
                    .padding()
                    .background(.white)
            }
            NavigationView {
                List(selection: $selection) {
                    ForEach(assignmentList, id: \.self) { hw in
                        if (hw.dueDay == getDay() && hw.dueMonth == getMonth() && hw.dueYear == getYear()) {
                            VStack {
                                HomeworkCard(test: hw)
                            }
                            .listRowBackground(hw.theme.mainColor)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: deleteButton, trailing: editButton)
                .environment(\.editMode, self.$editMode)
                .padding(.top, 0)
                
            }
            .background(.white)
        }
        .background(.white)
        .frame(minWidth: 0, maxWidth: .infinity)
        
        VStack {
            Text("**Add Assignment**")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 22))
            Form {
                Picker("Class name", selection: $selectedClass) {
                    Text("Math").tag("Math")
                    Text("Science").tag("Science")
                    Text("English").tag("English")
                    Text("History").tag("History")
                    Text("Art").tag("Art")
                }

                TextField(
                    "Assignment title",
                    text: $_assignmentName
                )
        
                HStack() {
                    Text("Due date: " + getDate())
                }
                .padding(.top, 20)
                Button(action: {createNewAssignment(); isPresented = false; presentationMode.wrappedValue.dismiss()} ) {
                    Text("Create new assignment")
                        .padding(.bottom, 3)
                }
                .buttonStyle(.bordered)
                .padding()
            }
            
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    
    func delete(at offsets: IndexSet) {
        assignmentList.remove(atOffsets: offsets)
    }
    
    func createNewAssignment() {
        assignmentList.append(Assignment(name: _assignmentName, dueYear: getYear(), dueMonth: getMonth(), dueDay: getDay(), theme: .bubblegum, className: selectedClass))
    }
    
    func getDay() -> Int {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd"
        let day = formatter1.string(from: date)
        return (day as NSString).integerValue
    }
    
    func getMonth() -> Int {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "MM"
        let month = formatter1.string(from: date)
        return (month as NSString).integerValue
    }
    
    func getYear() -> Int {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "YYYY"
        let year = formatter1.string(from: date)
        return (year as NSString).integerValue
    }
    
    func getDate() -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "MM/dd/YYYY"
        return formatter1.string(from: date)
    }
    
    func checkEmpty() -> Bool {
        let assignmentsToday = assignmentsOnDate(_dueYear: getYear(), _dueMonth: getMonth(), _dueDay: getDay())
        if (assignmentsToday.isEmpty) {
            return true
        }
        return false
    }
    
    private var editButton: some View {
        if editMode == .inactive {
            return Button(action: {
                self.editMode = .active
                self.selection = Set<Assignment>()
            }) {
                Text("Edit")
            }
        }
        else {
            return Button(action: {
                self.editMode = .inactive
                self.selection = Set<Assignment>()
            }) {
                Text("Done")
            }
        }
    }
    
    private var deleteButton: some View {
        if editMode == .inactive {
            return Button(action: {}) {
                Image(systemName: "")
            }
        } else {
            return Button(action: deleteHW) {
                Image(systemName: "trash")
            }
        }
    }
    
    private func deleteHW() {
        for id in selection {
            if let index = assignmentList.lastIndex(where: { $0 == id })  {
                assignmentList.remove(at: index)
            }
        }
        selection = Set<Assignment>()
    }
}

