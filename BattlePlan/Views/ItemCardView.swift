import SwiftUI

struct ItemCardView: View {
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
//            Spacer()
            Text(item.durationText)
                .font(.caption)
            // TODO Add resolved timestamp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView(item: Plan.sampleData.items[0])
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
