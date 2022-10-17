import SwiftUI


struct HomeworkCard: View {
    @State var test: Assignment
    var body: some View {
        VStack(alignment: .leading) {
            Text(test.name)
                .font(.headline)
                .padding(.bottom, 5)
                .font(.headline)
            HStack {
                Text(test.className)
                    .padding(.trailing, 7)
                Spacer()
                Text(String(test.dueMonth) + "/" + String(test.dueDay) + "/" + String(test.dueYear))
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(test.theme.accentColor)
    }
}
