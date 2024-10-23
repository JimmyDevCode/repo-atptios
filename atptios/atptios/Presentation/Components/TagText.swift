import SwiftUI
struct TagText: View {
    let text: StatesBet
    
    var body: some View {
        VStack {
            Text(text.labelText)
                .font(.system(size: 10))
                .fontWeight(.bold)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 6)
        }
        .background(text.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct CTagText_Previews: PreviewProvider {
    static var previews: some View {
        TagText(text: .simple)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}
