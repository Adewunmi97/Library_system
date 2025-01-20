module LibrarySystem
  class ValidationError < StandardError; end
  class BookError < StandardError; end
  class MemberError < StandardError; end
  class TransactionError < StandardError; end
end

module Errors
  class BookNotAvailableError < StandardError; end
  class DuplicateBookError < StandardError; end
  class BookNotFoundError < StandardError; end
  class LibraryError < StandardError; end
end 