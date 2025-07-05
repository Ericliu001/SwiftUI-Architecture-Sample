/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 A table view that maps information of a contact object.
 */

import SwiftUI

struct ContactTable: View {
    let router: ContactRouter
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool { horizontalSizeClass == .compact }
#else
    private let isCompact = false
#endif
    @Environment(DataModel.self) private var dataModel
    @State private var isTargeted = false
    
    var body: some View {
        Table(of: Contact.self) {
            TableColumn("Photo") { contact in
                if isCompact {
                    CompactContactView(router: router, contact: contact)
                } else {
                    ThumbnailView(contact: contact)
                }
            }
            .width(min: Constants.cardWidth)
            TableColumn("Given Name") { contact in
                Text(contact.givenName)
            }
            TableColumn("Family Name", value: \.familyName)
            TableColumn("Phone Number", value: \.phoneNumber)
            TableColumn("Email") { contact in
                Text(contact.email ?? "")
            }
            TableColumn("Message"){ contact in
                Button {
                    router.gotoConversation(recipient: contact)
                }  label: {
                    Image(systemName: "message.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                }
                .buttonStyle(.plain)
            }
            //            TableColumn("Video title") { contact in
            //                if let videoTitle = contact.videoURL?.lastPathComponent {
            //                    Text(videoTitle)
            //                }
            //            }
        } rows: {
            ForEach(dataModel.contacts) { contact in
                TableRow(contact)
                    .draggable(contact)
            }
            .dropDestination(for: Contact.self) {
                index,
                droppedContacts in
                dataModel
                    .handleDroppedContacts(
                        droppedContacts: droppedContacts,
                        index: index
                    )
            }
        }
        .frame(alignment: .center)
        .background(isTargeted ? Color.blue.opacity(0.2) : Color.clear)
        .dropDestination(for: Contact.self) { droppedContacts, location in
            dataModel.handleDroppedContacts(droppedContacts: droppedContacts)
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
    }
}

struct CompactContactView: View {
    let router: ContactRouter
    let contact: Contact
    
    var body: some View {
        Button(action: {
            router.gotoContactDetail(contact)
        }
        ) {
            HStack {
                ThumbnailView(contact: contact)
                VStack(alignment: .leading) {
                    Text(contact.fullName)
                    Text(contact.phoneNumber)
                        .foregroundStyle(.secondary)
                    Text(contact.email ?? "")
                        .foregroundStyle(.secondary)
                
                    Button(action: {
                        router.gotoConversation(recipient: contact)
                    }) {
                        Image(systemName: "message.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct VideoLabelView: View {
    var videoName: String
    var body: some View {
        HStack {
            Image(systemName: "play.circle.fill")
                .foregroundStyle(.blue)
                .imageScale(.large)
            Text(videoName)
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }
}

#Preview {
    ContactTable(router: MockContactRouter.shared)
        .environment(DataModel())
}
