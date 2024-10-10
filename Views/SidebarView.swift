import SwiftUI

struct SidebarView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TaskItemListView()) {
                    Label("TaskItems", systemImage: "checklist")
                }
                NavigationLink(destination: UserManagementView()) {
                    Label("Users", systemImage: "person.3")
                }
                NavigationLink(destination: ReportsView()) {
                    Label("Reports", systemImage: "chart.bar") // Updated system image
                }
                // Add more navigation items as needed
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("TaskItemMaster Pro")
        }
    }
}
