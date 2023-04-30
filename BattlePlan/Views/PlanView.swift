import SwiftUI

struct PlanView: View {
    @Binding var plan: Plan
    
    let dateRange: ClosedRange<Date> = {
        let now = Date.now
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: now)
        var startComponents = todayComponents
        startComponents.hour = 0
        startComponents.minute = 0
        var endComponents = todayComponents
        endComponents.hour = 23
        endComponents.minute = 59
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        VStack {
            NavigationStack {
                let itemDeadlines = plan.itemDeadlines
                List(plan.items.indices, id: \.self) { idx in
                    NavigationLink(destination: ItemEditView(item: $plan.items[idx])) {
                        ItemCardView(item: plan.items[idx], deadline: itemDeadlines[idx])
                    }
                }
                .navigationTitle("Battle Plan")
                
                DatePicker(
                    "Deadline",
                    selection: $plan.deadline,
    //                 in: dateRange,
                     displayedComponents: [.hourAndMinute]
                )
                .padding([.horizontal])
            }
        }
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(plan: .constant(Plan.sampleData))
    }
}
