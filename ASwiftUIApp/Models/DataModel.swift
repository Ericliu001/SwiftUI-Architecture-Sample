/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Manages assets loaded from the photo library.
*/

import SwiftUI
import PhotosUI

@Observable
class DataModel {
    var contacts: [Contact] = Contact.mock
    var displayMode: ContactDetailView.DisplayMode = .list

    func handleDroppedContacts(droppedContacts: [Contact], index: Int? = nil) {
        guard let firstContact = droppedContacts.first else {
            return
        }
        // If the id of the first contact exists in the contacts list,
        // move the contact from its current position to the new index.
        // If an index isn't specified, insert the contact at the end of the list.
        if let existingIndex = contacts.firstIndex(where: { $0.id == firstContact.id }) {
            let indexSet = IndexSet(integer: existingIndex)
            contacts.move(fromOffsets: indexSet, toOffset: index ?? contacts.endIndex)
        } else {
            contacts.insert(firstContact, at: index ?? contacts.endIndex)
        }
    }

    /// Converts the binary data to an Image.
    static func loadImage(from data: Data?) -> Image? {
        guard let data else { return nil }
        #if canImport(UIKit)
        if let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        #elseif canImport(AppKit)
        if let nsImage = NSImage(data: data) {
            return Image(nsImage: nsImage)
        }
        #endif
        return nil
    }
    
    static func loadItem(selection: PhotosPickerItem?) async throws -> Video? {
        try await selection?.loadTransferable(type: Video.self)
    }
}

struct Video: Transferable {
    var url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { item in
            SentTransferredFile(item.url)
        } importing: { received in
            let url = try Video.copyLibraryFile(from: received.file)
            return Video(url: url)
        }
    }
    
    /// Copies a file from source URL to a user's library directory.
    static func copyLibraryFile(from source: URL) throws -> URL {
        let libraryDirectory = try FileManager.default.url(
            for: .libraryDirectory, in: .userDomainMask,
            appropriateFor: nil, create: true
        )
        var destination = libraryDirectory.appendingPathComponent(
            source.lastPathComponent, isDirectory: false)
        if FileManager.default.fileExists(atPath: destination.path) {
            let pathExtension = destination.pathExtension
            var fileName = destination.deletingPathExtension().lastPathComponent
            fileName += "_\(UUID().uuidString)"
            destination = destination
                .deletingLastPathComponent()
                .appendingPathComponent(fileName)
                .appendingPathExtension(pathExtension)
        }
        try FileManager.default.copyItem(at: source, to: destination)
        return destination
    }
}

