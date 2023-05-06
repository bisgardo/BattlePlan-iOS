import SwiftUI

@main
struct BattlePlanApp: App {
//    @State var plan = Plan.sampleData // TODO
    @State var plan = Plan(items: [], deadline: Date.now)
    
    var body: some Scene {
        WindowGroup {
            PlanView(plan: $plan)
        }
    }
}
