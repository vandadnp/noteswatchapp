import Foundation

class GameTimer {
    
    typealias Started = () -> Void
    private var timer: Timer?
    private var started: Started?
    private var counter = 0
    private static let max = 5
    
    init(
        autoStart: Bool = true,
        onStarted: Started?
    ) {
        self.started = onStarted
        if autoStart {
            start()
        }
    }
    
    func start() {
        stop()
        started?()
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: { [weak self] _ in
                guard let self = self else { return }
                self.counter += 1
                if self.counter >= GameTimer.max {
                    self.counter = 0
                    self.started?()
                }
            }
        )
    }
    
    func stop() {
        timer?.invalidate()
    }
}
