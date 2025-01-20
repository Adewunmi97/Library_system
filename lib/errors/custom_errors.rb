module Errors
  class ValidationError < StandardError; end
  class BookNotAvailableError < StandardError; end
  class DuplicateBookError < StandardError; end
  class BookNotFoundError < StandardError; end
  class LibraryError < StandardError; end
  class BookError < StandardError; end
  class MemberError < StandardError; end
end 