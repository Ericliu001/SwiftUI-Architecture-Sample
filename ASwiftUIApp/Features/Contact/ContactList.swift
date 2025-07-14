/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 A view that displays a list of contacts.
 */

import SwiftUI
import Contacts
import UniformTypeIdentifiers

struct ContactList: View {
    @State private var isTargeted = false
    
    let scope: ContactScope
    
    var body: some View {
        List {
            ForEach(scope.dataModel.contacts) { contact in
                Button (action: {
                    scope.router.gotoContactDetail(contact)
                }) {
                    CompactContactView(router: scope.router, contact: contact)
                        .draggable(contact) {
                            ThumbnailView(contact: contact)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .draggable(contact)
            }
            .dropDestination(for: Contact.self) {
                droppedContacts,
                index in
                scope.dataModel
                    .handleDroppedContacts(
                        droppedContacts: droppedContacts,
                        index: index
                    )
            }
            .onMove { fromOffsets, toOffset in
                scope.dataModel.contacts
                    .move(fromOffsets: fromOffsets, toOffset: toOffset)
            }
            .onDelete { indexSet in
                scope.dataModel.contacts.remove(atOffsets: indexSet)
            }
        }
#if !os(macOS)
        .listStyle(.insetGrouped)
        .toolbar {
            EditButton()
        }
#endif
    }
}

#Preview {
    ContactList(scope: ContactScope.mock)
}
