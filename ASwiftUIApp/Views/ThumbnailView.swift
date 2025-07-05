/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays the contact's profile thumbnail picture.
*/

import SwiftUI

struct ThumbnailView: View {
    var contact: Contact
    
    var body: some View {
        Group {
            if let thumbnailData = contact.thumbNail,
                let image = DataModel.loadImage(from: thumbnailData) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .draggable(image)
            } else {
                Circle()
                    .fill(Color.gray)
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Text(contact.initials)
                            .font(.title)
                            .bold()
                    }
            }
        }
        .frame(maxWidth: Constants.cardWidth, maxHeight: Constants.cardHeight)
    }
}

extension Contact {
    var initials: String {
          let givenInitial = givenName.prefix(1).uppercased()
          let familyInitial = familyName.prefix(1).uppercased()
          return "\(givenInitial)\(familyInitial)"
    }
}

#Preview("Contact without thumbnail") {
    ThumbnailView(contact: .mock[0])
}

#Preview("Contact with thumbnail") {
    ThumbnailView(contact: .mock[4])
}
