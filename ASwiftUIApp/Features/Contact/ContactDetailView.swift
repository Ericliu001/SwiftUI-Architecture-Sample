/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A detail view the app uses to display a contact's information - full name, initials, and thumbnail picture.
*/

import SwiftUI

struct ContactDetailView: View {
    enum DisplayMode: String, CaseIterable, Identifiable {
        var id: Self { self }
        case table
        case list
    }
    
    let router: ContactRouter
    var contact: Contact
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    HeaderView(
                        contact: contact,
                        height: geometry.size.height,
                        width: geometry.size.width
                    )
                    ContactInfoView(router: router, contact: contact)
                }
            }
        }
    }
}

#Preview {
    ContactDetailView(router: MockContactRouter.shared, contact: .mock.first!)
}
