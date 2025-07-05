/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The top level tab navigation for the app.
*/

import SwiftUI

struct DisplayModePicker: View {
    @Binding var mode: ContactDetailView.DisplayMode

    var body: some View {
        Picker("Display Mode", selection: $mode) {
            ForEach(ContactDetailView.DisplayMode.allCases) { mode in
                mode.label
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

extension ContactDetailView.DisplayMode {
    var labelContent: (name: String, systemImage: String) {
        switch self {
        case .table:
            return ("Table", "tablecells")
        case .list:
            return ("List", "list.bullet")
        }
    }

    var label: some View {
        let content = labelContent
        return Label(content.name, systemImage: content.systemImage)
    }
}

