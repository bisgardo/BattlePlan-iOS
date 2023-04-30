import SwiftUI

struct ItemEditView: View {
    @Binding var item: Item
    
    @State private var editingItem: Item = Item(title: "", durationMinutes: 0) // dummy item
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $editingItem.title)
            }
            Section(header: Text("Duration")) {
                HStack {
                    Slider(value: Binding(
                        get: {
                            Double($editingItem.durationMinutes.wrappedValue)
                        },
                        set: {
                            $editingItem.durationMinutes.wrappedValue = Int($0)
                        }), in: 1...30, step: 1) {
                        Text("Duration")
                    }
                    .accessibilityValue(editingItem.durationText)
                    Spacer()
                    Text(editingItem.durationText)
                        .accessibilityHidden(true)
                }
            }
        }
        .navigationTitle("Edit Item")
        .onAppear {
            editingItem = item
        }
        .onDisappear {
            item = editingItem
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditView(item: .constant(Plan.sampleData.items[0]))
    }
}
