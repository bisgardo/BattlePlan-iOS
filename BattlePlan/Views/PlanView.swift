import SwiftUI

struct PlanView: View {
    @Binding var plan: Plan
    @State private var showingEditView = false
    
    @State var editItem: Binding<Item>?
    
    static let formatter = {
        let f = RelativeDateTimeFormatter()
        f.dateTimeStyle = .named
        return f
    }()
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    let itemDeadlines = plan.itemDeadlines
                    if let startTime = itemDeadlines.first {
                        let durationSinceNow = startTime.timeIntervalSinceNow
                        Text("\(durationSinceNow > 0 ? "Starting" : "Started") \(Self.formatter.localizedString(fromTimeInterval: durationSinceNow))")
                    } else {
                        Text("Click '+' to add plan item")
                    }
                    
                    List(plan.items.indices, id: \.self) { idx in
                        ItemCardView(item: plan.items[idx], deadline: itemDeadlines[idx])
                            .contentShape(Rectangle())
                            .onTapGesture {
                                editItem = $plan.items[idx]
                            }
                    }
                    
                    DatePicker(
                        "Deadline",
                        selection: $plan.deadline,
                        displayedComponents: [.hourAndMinute]
                    )
                    .padding([.horizontal])
                    .font(.title2)
                    Text(Self.formatter.localizedString(fromTimeInterval: plan.deadline.timeIntervalSinceNow))
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding([.trailing])
                        
                }
                .navigationTitle("Battle Plan")
                .toolbar {
                    Button(action: {
                        // Cannot set 'editItem' to this item as that causes an index out of bounds exception somewhere - Swift isn't able to tell where...
                        plan.items.append(Item(title: "New Item", durationMinutes: 0))
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Item")
                }.sheet(item: $editItem) { $item in
                    NavigationView { // for showing nav title
                        ItemEditView(item: $item)
                    }
                }
            }
        }
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(plan: .constant(Plan.sampleData))
    }
}
