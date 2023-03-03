import SwiftUI

struct SegmentedControlView: View {
    @Binding private var selectedIndex: Int

    @State private var frames: Array<CGRect>
    @State private var backgroundFrame = CGRect.zero

    private let titles: [String]

    init(selectedIndex: Binding<Int>, titles: [String]) {
        self._selectedIndex = selectedIndex
        self.titles = titles
        frames = Array<CGRect>(repeating: .zero, count: titles.count)
    }

    var body: some View {
        VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, titles: titles)
                }
        }
        .background(
            GeometryReader { geoReader in
                Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                    .onPreferenceChange(RectPreferenceKey.self) {
                    self.setBackgroundFrame(frame: $0)
                }
            }
        )
    }

    private func setBackgroundFrame(frame: CGRect)
    {
        backgroundFrame = frame
    }
}

private struct SegmentedControlButtonView: View {
    @Binding private var selectedIndex: Int
    @Binding private var frames: [CGRect]
    @Binding private var backgroundFrame: CGRect

    private let titles: [String]

    init(selectedIndex: Binding<Int>, frames: Binding<[CGRect]>, backgroundFrame: Binding<CGRect>, titles: [String])
    {
        _selectedIndex = selectedIndex
        _frames = frames
        _backgroundFrame = backgroundFrame

        self.titles = titles
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(titles.indices, id: \.self) { index in
                Button(action:{ selectedIndex = index })
                {
                    HStack {
                        Text(titles[index])
                            .bold()
                            .frame(height: 42)
                            .foregroundColor(selectedIndex == index ? Color.white : Color.black)
                    }
                }
                .buttonStyle(CustomSegmentButtonStyle())
                .background(
                    GeometryReader { geoReader in
                        Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                            .onPreferenceChange(RectPreferenceKey.self) {
                                self.setFrame(index: index, frame: $0)
                            }
                    }
                )
            }
        }
        .modifier(UnderlineModifier(selectedIndex: selectedIndex, frames: frames))
    }

    private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame

    }
}

private struct CustomSegmentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
            .background(Color.clear)
    }
}



struct UnderlineModifier: ViewModifier
{
    var selectedIndex: Int
    let frames: [CGRect]

    func body(content: Content) -> some View
    {
        content
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.blue)
                    .frame(width: frames[selectedIndex].width, height: 50)
                    .offset(x: frames[selectedIndex].minX - frames[0].minX), alignment: .leading
            )
            .animation(.default)
    }
}

struct RectPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue = CGRect.zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect)
    {
        value = nextValue()
    }
}


struct CustomSegmentedView_Previews: PreviewProvider {
    @State static var selectedIndex: Int = 0

    static var previews: some View {
        let titles: [String] =
            ["First",
             "Sixteenth",
             "Seventeenth",
             "Eighteenth",
             "Nineteenth",
             "Tweentieth"
            ]

        Group
        {
            SegmentedControlView(selectedIndex: $selectedIndex, titles: titles)
        }
    }
}

struct Wrapper: View {
    @State var selectedIndex: Int = 0

    var body: some View {
        let titles: [String] =
            ["First",
             "Eighteenth",
             "Nineteenth",
             "Tweentieth"
            ]

        SegmentedControlView(selectedIndex: $selectedIndex, titles: titles)
    }
}
