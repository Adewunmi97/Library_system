require 'securerandom'

class Member
    attr_accessor :name, :email, :membership_status
    attr_reader :id, :borrowed_books
    def initialize(name:, email:)
    @id = generate_unique_id
    @name = name
    @email = email
    @membership_status = "active"
    @borrowed_books = []
    end

    def check_membership(name, email)
        if @name == name && @email == email
            @membership_status
        else
            @membership_status = "in-active"
        end    
    end

    def borrow_book(book)
        if @borrowed_books.include?(book)
            puts "#{book.title} has been borrowed"
        else
            @borrowed_books << book
            book.status = "borrowed"
        end
    end

    def return_book(book)
        if @borrowed_books.include?(book)
            @borrowed_books.delete(book)
            book.status = "available"
        else
            puts "#{book.title} has not been borrowed"
        end
    end
end