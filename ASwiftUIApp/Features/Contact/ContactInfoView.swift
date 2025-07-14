/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays the contact information — full name, initials, email, and note.
*/

import SwiftUI

struct ContactInfoView: View {
    let scope: ContactScope
    var contact: Contact

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                ThumbnailView(contact: contact)
                Text(contact.fullName)
                    .font(.title)
                    .bold()
            }
            .padding(.horizontal)
            VStack {
                LabeledContent("Phone number") {
                    HStack {
                        Text(contact.phoneNumber)

                        Spacer()

                        Button(action: {
                            scope.router.gotoConversation(recipient: contact)
                        }) {
                            Image(systemName: "message.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .buttonStyle(.plain)
                    }
                }
                .draggable(contact.phoneNumber)
                if let email = contact.email {
                    LabeledContent("Email") {
                        Text(email)
                    }
                    .draggable(email)
                }
                if let videoURL = contact.videoURL {
                    LabeledContent("Video") {
                        VideoLabelView(videoName: videoURL.lastPathComponent)
                    }
                    .draggable(videoURL)
                }
            }
            .labeledContentStyle(ContactDetailLabelStyle())
            .padding()
        }
        .toolbar {
            // Load the contact's thumbnail image or a default image.
            let image = DataModel.loadImage(from: contact.thumbNail) ?? Image("gender-neutral")
            ShareLink(item: contact, preview: SharePreview(contact.fullName, image: image)) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
    }
}

struct ContactDetailLabelStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            VStack(alignment: .leading) {
                configuration.label
                    .font(.headline)
                    .foregroundColor(.secondary)
                configuration.content
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.gray.opacity(0.1))
        )
    }
}

#Preview {
    ContactInfoView(scope: ContactScope.mock, contact: .mock[0])
}
