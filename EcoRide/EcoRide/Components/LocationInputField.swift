import SwiftUI

struct LocationInputField: View {
    @Binding var text: String
    var placeholder: String
    var icon: String
    var suggestions: [String]
    var onTextChange: (String) -> Void
    var onSelectSuggestion: (String) -> Void
    
    @State private var showSuggestions = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Color(.systemGreen))
                    .padding(.horizontal, 8)
                Spacer()
                TextField(placeholder, text: $text)
                    .onChange(of: text) { newValue in
                        showSuggestions = !newValue.isEmpty
                        onTextChange(newValue)
                    }
                    .onTapGesture {
                        if !text.isEmpty {
                            showSuggestions = true
                        }
                    }
            }
            // Suggestions List
            if showSuggestions && !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        Text(suggestion)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .onTapGesture {
                                text = suggestion
                                showSuggestions = false
                                onSelectSuggestion(suggestion)
                            }
                        Divider()
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .shadow(radius: 4)
            }
        }
        Divider()
    }
}
