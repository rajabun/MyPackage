//
//  TimerView.swift
//
//  Created by Priharsanto, Muhammad Rajab on 15/05/25.
//

import Combine

#if canImport(SwiftUI)
import SwiftUI
#endif

#Preview {
    let vm = TimerViewModel(generatedDate: "2025-06-02T19:31:00+07:00")
    TimerView(viewModel: vm)
}

public class TimerViewModel: ObservableObject {
    enum ViewState {
        case success
        case loading
        case error
    }

    private var timer: Cancellable?
    private var timeRemaining: TimeInterval
    @Published var viewState: ViewState
    @Published var generatedDate: String
    
    public init(timer: Cancellable? = nil, timeRemaining: TimeInterval = 10, viewState: ViewState = .success, generatedDate: String = "") {
        self.timer = timer
        self.timeRemaining = timeRemaining
        self.viewState = viewState
        self.generatedDate = generatedDate
        
        self.startTimer(time: generatedDate)
    }
    
    public func startTimer(time: String) {
        let dates = dateFromString(string: time,
                                   format: .fullDateWithTimezoneWithoutSSS)
        let timeIntervalSeconds = dates.timeIntervalSince(Date())
        timeRemaining = timeIntervalSeconds
        
        timer = Timer.publish(every: 1, on: .current, in: .default)
            .autoconnect()
            .sink { _ in } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                if timeRemaining > 2 {
                    timeRemaining -= 1
                    let currentDate = Date(timeIntervalSince1970: timeRemaining)
                    let calendar = Calendar.current
                    let minutes = calendar.component(.minute, from: currentDate)
                    let seconds = calendar.component(.second, from: currentDate)
                    generatedDate = String.init(format: "%02d:%02d", minutes, seconds)
                } else {
                    timer?.cancel()
                    viewState = .error
                }
            }
    }
}

public struct TimerView: View {
    @ObservedObject public var viewModel: TimerViewModel
    @State public var time: String = "00:00"
    
    public var body: some View {
        VStack {
            HStack {
                Text(viewModel.viewState == .success ? "Kadaluwarsa dalam" : "Waktu habis")
//                    .font(.style(MPFonts.smallMedium))
                Text(viewModel.viewState == .success ? time : "")
//                    .font(.style(MPFonts.smallBold))
            }
            .padding(.top, 8)
        }
        .valueChanged(value: viewModel.generatedDate, onChange: {
            time = $0
        })
    }
}

//extension Font {
//    static func style(_ style: UIFont?) -> Font {
//        return Font.custom(style?.fontName ?? MPFonts.defaultFontFamily(), size: style?.pointSize ?? MPFonts.defaultFontSize())
//    }
//}

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder public func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
}
