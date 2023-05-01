import SwiftUI

struct ItemCardView: View {
    static let deadlineFormat = Date.FormatStyle().hour().minute()
    var item: Item
    var deadline: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            HStack {
                Text(item.durationText)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Label(deadline.formatted(Self.deadlineFormat), systemImage: "clock")
                    .font(.caption)
                    .labelStyle(.trailingIcon)
                    .padding([.trailing], 4)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView(item: Plan.sampleData.items[0], deadline: Date.now)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
