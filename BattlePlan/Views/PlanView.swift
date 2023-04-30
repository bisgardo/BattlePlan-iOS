import SwiftUI

struct PlanView: View {
    @Binding var plan: Plan
    
    var body: some View {
        NavigationStack {
            List($plan.items) { $item in
                NavigationLink(destination: ItemEditView(item: $item)) {
                    ItemCardView(item: item)
                }
            }
            .navigationTitle("Plan")
        }
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(plan: .constant(Plan.sampleData))
    }
}
