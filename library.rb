class Library
    attr_reader :name, :books, :members
    def initialize(name:)
    @name = name
    @books = []
    @members = []
    end

    def add_member(member)
        @member << member
    end

    def add_book(book)
        @books << book
    # Add validation and book addition logic
    end

    def remove_book(book_id)
        @books.delete(book_id)
    # Add book removal logic
    end
    def search_books(query)
        @books.select { |book| book.query == query }
    # Implement search functionality
    end
end