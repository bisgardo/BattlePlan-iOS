import SwiftUI

struct PlanView: View {
    @Binding var plan: Plan
    
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
                    }
                    
                    List(plan.items.indices, id: \.self) { idx in
                        NavigationLink(destination: ItemEditView(item: $plan.items[idx])) {
                            ItemCardView(item: plan.items[idx], deadline: itemDeadlines[idx])
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
                        plan.items.append(Item(title: "New Item", durationMinutes: 0))
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Item")
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
