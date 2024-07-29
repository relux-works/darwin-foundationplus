actor AsyncLock {
	private let semaphore: AsyncSemaphore
	
	init() {
		self.semaphore = AsyncSemaphore(value: 1)
	}
	
	func withLock<T: Sendable>(_ operation: () async throws -> T) async rethrows -> T {
		await semaphore.wait()
		defer { semaphore.signal() }
		return try await operation()
	}
}
