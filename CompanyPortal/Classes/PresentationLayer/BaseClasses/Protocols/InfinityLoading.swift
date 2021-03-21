import Foundation

protocol RefreshEventHandler: class {
    func refresh()
}

protocol RefreshBehavior {
    func showRefreshIndicator() -> ActivityDisposable?
}

protocol InfinityLoadingEventHandler: class {
    func refresh()
    func loadMore()
}

protocol InfinityLoadingBehavior {
    func loadPageProgress(show: Bool)
}

extension InfinityLoadingEventHandler {
    func refresh() {}

    func loadMore() {}
}
