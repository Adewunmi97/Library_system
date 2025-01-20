require 'securerandom'
require_relative '../concerns/id_module'
require_relative '../errors/custom_errors'
require_relative 'book'
require_relative 'member'
require_relative 'transaction'

module LibrarySystem
  class Library
    include Errors
    include IDGenerator

    attr_reader :name, :books, :members, :transactions

    def initialize(name:)
      @id = generate_unique_id
      @name = name
      @books = []
      @members = []
      @transactions = []
    end

    def add_book(book)
      raise ValidationError, "Book already exists" if find_book(book.id)
      @books << book
      book
    end

    def add_member(member)
      raise ValidationError, "Member already exists" if find_member(member.id)
      @members << member
      member
    end

    def remove_book(book_id)
      book = find_book(book_id)
      raise LibraryError, "Cannot remove borrowed book" unless book.available?
      @books.delete(book)
      book
    end

    def search_books(query)
      query = query.to_s.downcase
      @books.select do |book|
        book.title.downcase.include?(query) ||
          book.author.downcase.include?(query) ||
          book.isbn.include?(query)
      end
    end

    def register_member(name:, email:)
      member = Member.new(name: name, email: email)
      validate_member_uniqueness(member)
      @members << member
      member
    end

    def process_checkout(member_id:, book_id:)
      member = find_member(member_id)
      book = find_book(book_id)
      
      raise ValidationError, "Member not found" unless member
      raise ValidationError, "Book not found" unless book
      
      transaction = member.borrow_book(book)
      @transactions << transaction
      transaction
    end

    def process_return(member_id:, book_id:)
      member = find_member(member_id)
      book = find_book(book_id)
      
      raise ValidationError, "Member not found" unless member
      raise ValidationError, "Book not found" unless book
      
      member.return_book(book)
      transaction = find_transaction(book, member)
      transaction.complete_return
    end

    # Debug methods
    def list_all_books
      puts "\nAll Books in Library:"
      @books.each do |book|
        puts "#{book.title} by #{book.author} (#{book.status})"
      end
    end

    def list_all_members
      puts "\nAll Members in Library:"
      @members.each do |member|
        puts "#{member.name} (#{member.email})"
      end
    end

    def find_book(book_id)
      @books.find { |book| book.id == book_id }
    end

    def find_member(member_id)
      @members.find { |member| member.id == member_id }
    end

    def find_transaction(book, member)
      @transactions.find { |t| t.book == book && t.member == member && !t.returned? } ||
        raise(LibraryError, "Transaction not found")
    end

    private

    def book_exists?(isbn)
      @books.any? { |book| book.isbn == isbn }
    end

    def member_exists?(email)
      @members.any? { |member| member.email == email }
    end

    def validate_book_uniqueness(book)
      raise LibraryError, "Book with ISBN already exists" if @books.any? { |b| b.isbn == book.isbn }
    end

    def validate_member_uniqueness(member)
      raise LibraryError, "Member with email already exists" if @members.any? { |m| m.email == member.email }
    end
  end
end 