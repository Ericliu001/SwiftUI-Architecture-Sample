/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a video thumbnail or a placeholder if a video isn't available.
*/
import SwiftUI
import AVKit
import PhotosUI

struct HeaderView: View {
    @Environment(DataModel.self) private var dataModel
    @State private var photosPickerPresented = false
    @State private var selection: PhotosPickerItem?
    @State private var isTargeted = false
    var contact: Contact
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        VStack {
            if let videoUrl = contact.videoURL {
                VideoView(videoUrl: videoUrl)
                    .frame(width: width, height: height * Constants.ratio)
            } else {
                ContentUnavailableView {
                    Button {
                        photosPickerPresented = true
                    } label: {
                        Image(systemName: "video.fill")
                    }
                } description: {
                    Text("Add a video to the contact or drag and drop a video file here.")
                }
                .frame(width: width, height: height * Constants.ratio)
                .background(LinearGradient(colors: [.blue.opacity(0.2), .clear], startPoint: .top, endPoint: .bottom))
            }
        }
        .background(isTargeted ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
        .dropDestination(for: Video.self) { droppedVideos, _ in
            // Find the contact's index and update the video URL.
            guard
                let video = droppedVideos.first,
                let index = dataModel.contacts.firstIndex(where: { $0.id == contact.id })
            else {
                return false
            }
            dataModel.contacts[index].videoURL = video.url
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
        .photosPicker(
            isPresented: $photosPickerPresented,
            selection: $selection,
            matching: .any(of: [.videos]),
            preferredItemEncoding: .automatic,
            photoLibrary: .shared()
        )
        .onChange(of: selection) {
            Task {
                let video = try await DataModel.loadItem(selection: selection)
                // Update the contact's video URL in the data model
                if let index = dataModel.contacts.firstIndex(where: { $0.id == contact.id }) {
                    dataModel.contacts[index].videoURL = video?.url
                }
            }
        }
    }
}

// Displays and controls video playback.
struct VideoView: View {
    var videoUrl: URL
    @State private var player: AVPlayer?
    
    var body: some View {
        VideoPlayer(player: player)
        .task {
            self.player = AVPlayer(url: videoUrl)
        }
    }
}

#Preview {
    HeaderView(contact: .mock[4], height: 500, width: 500)
        .environment(DataModel())
}
