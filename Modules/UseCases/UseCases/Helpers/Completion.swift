// MARK: Completions

public typealias UICompletionResult<ResponseType> = (UIResult<ResponseType>) -> Void

public typealias Completion<ResponseType> = (Result<ResponseType>) -> Void
