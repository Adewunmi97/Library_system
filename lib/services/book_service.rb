module LibrarySystem
  class BookService
    def initialize(library)
      @library = library
    end

    def add_book(title:, author:, isbn:)
      book = LibrarySystem::Book.new(title: title, author: author, isbn: isbn)
      @library.add_book(book)
    end

    def search_books(query)
      @library.search_books(query)
    end
  end
end 