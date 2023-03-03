import SwiftUI
struct ProgressView: View {
    var body: some View {
        VStack {
            ContainerView()
        }.padding()
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
//
//class ViewModel: ObservableObject {
//    var date : String = "Aug. 27 Friday"
//    var progress : Float = 0.4
//
//    @Published var progressValue: Float
//
//    init(progress: Float) {
//        progressValue = progress
//    }
//}

struct ContainerView: View {
    //    @State var viewModel = ViewModel()
    @State var progressValue: Float = 0.0
    @State var dateValue: String = ""
    var body: some View {
        VStack {
            
            Button("Progress +1") {
                progressValue += 0.01
                if progressValue >= 1.001 {progressValue = 1.0}
            }
            Button("Progress +10") {
                progressValue += 0.1
                if progressValue >= 1.001 {progressValue = 1.0}
            }
            Button("Progress -1") {
                progressValue -= 0.01
                if progressValue <= 0 {progressValue = 0.0}
            }
            Button("Progress -10") {
                progressValue -= 0.1
                if progressValue <= 0 {progressValue = 0.0}
            }
            ProgressBar(value: $progressValue, date: $dateValue)
                .frame(height: 80)
                .padding()
                .border(Color.black)
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    @Binding var date: String
    let barHeight = 4.0
    let textPadding = 30.0
    let label = "Your daily progress"
    let backgroundAlpha = 1.0
    let barSpacing = 2.0
    
    private func getpadding(width : CGFloat) -> CGFloat {
        if CGFloat(value) >= 0.93
        {
            return CGFloat(0.93)*width
        }
        if CGFloat(value) <= 0.03
        {
            return CGFloat(0.03)*width
        }
        return CGFloat(value)*width
    }
    
    private func getPercentString() -> String {
        let inputString = String(Int(round(self.value*100))) + "%"
        if inputString.count == 2 {
            return inputString + "   "
        }
        if inputString.count == 3 {
            return inputString + "  "
        }
        return inputString
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let width = geometry.size.width
                HStack {
                    Text(label)
                    Spacer()
                    Text(date)
                }
                
                .fixedSize(horizontal: false, vertical: true)
                HStack(spacing: barSpacing) {
                    
                    Rectangle().frame(width: CGFloat(self.value)*(width-barHeight*2-barSpacing*2), height: barHeight)
                        .mask(Capsule(style: .circular))
                    
                    Circle()
                        .frame(width: barHeight*2, height: barHeight*2, alignment: .center)
                    
                    Rectangle().frame(width: CGFloat(1.0-self.value)*(width-barHeight*2-barSpacing*2), height: barHeight)
                        .opacity(backgroundAlpha)
                        .mask(Capsule(style: .circular))
                }.padding(.top, textPadding)
                    .animation(.default, value: value)
                HStack {
                    Text(getPercentString())
                        .offset(x:getpadding(width: width-6))
                        .padding(.top, textPadding*1.5)
                        .fixedSize()
                        .animation(.default, value: value)
                        .padding(.leading, -10)
                    Spacer()
                }
                
            }
        }
    }
}
