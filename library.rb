class Library
    attr_reader :name, :books, :members
    def initialize(name:)
    @name = name
    @books = []
    @members = []
    end
    def add_book(book)
    # Add validation and book addition logic
    end
    def remove_book(book_id)
    # Add book removal logic
    end
    def search_books(query)
    # Implement search functionality
    end
end