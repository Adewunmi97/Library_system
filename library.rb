require_relative "member"
require_relative "book"
require_relative "transaction"

class Library
    attr_reader :name, :books, :members
    def initialize(name:)
    @name = name
    @books = []
    @members = []
    end

    def add_member(name:, email:)
        member = Member.new(name: name, email: email)
        @member << member
        member
    end

    def add_book(book)
        @books << book
        book
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

book1 = Book.new(title: "melann", author: "ade", isbn: "123")
lib = Library.new(name: "my lib")
lib.add_book(book1)