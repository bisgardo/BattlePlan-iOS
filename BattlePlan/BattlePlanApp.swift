import SwiftUI

@main
struct BattlePlanApp: App {
    @State var plan = Plan.sampleData // TODO
    
    var body: some Scene {
        WindowGroup {
            PlanView(plan: $plan)
        }
    }
}
