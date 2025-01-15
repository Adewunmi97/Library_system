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

    
    def add_book(book)
        @books << book
        book
    # Add validation and book addition logic
    end


    def remove_book(book_id)
        book = @books.find { |b| b.id == book_id }
        if book
            @books.delete(book_id)
        else
            raise "Book not found!"
        end
    end


    def search_books(query)
        if query.nil? || !query.is_a?(string)
            raise ArgumentError, "Query must be a non-empty srting!"
        end
        @books.select do |book|
            book.title.downcase.include?(query.downcase)||
            book.author.downcase.include?(query.downcase)||
            book.isbn.downcase.include?(query.downcase)
        end  # Implement search functionality
    end

    # Member management

    def add_member(member)
        @member << member
        member
    end

    def update_member(member_id, name:, email:)
        member = @members.find { |m| m.id == member_id}
        raise "Member not found" unless member
         member.name = name if name
         member.email = email if email
         member
    end
end

book1 = Book.new(title: "melann", author: "ade", isbn: "123")
lib = Library.new(name: "my lib")
lib.add_book(book1)
lib.search_books(book1.title)
lib.remove_book(book1.id)