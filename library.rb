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
        if query.nil? || !query.is_a?(String)
            raise ArgumentError, "Query must be a non-empty srting!"
            return []
        end
        @books.select do |book|
            book.title.downcase.include?(query.downcase)||
            book.author.downcase.include?(query.downcase)||
            book.isbn.downcase.include?(query.downcase)
        end  
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

    def no_of_borrowed_books_by_member(member)
        if @members.include?(member)
            member.borrowed_books.count
        else
            puts "Member not found in the library"
            0
        end
    end
end

book1 = Book.new(title: "melann", author: "ade", isbn: "123")
mem1= Member.new(name: "Ade", email: "sun@gmail.com")
lib = Library.new(name: "my lib")
lib.add_book(book1)
lib.search_books(book1.title)
lib.remove_book(book1.id)
lib.no_of_borrowed_books_by_member(mem1)