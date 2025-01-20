require_relative '../id_module'
require_relative '../errors/custom_errors'
require_relative 'book'
require_relative 'member'
require_relative 'transaction'

class Library
  include Errors

  attr_reader :name, :books, :members, :transactions

  def initialize(name:)
    @name = name
    @books = []
    @members = []
    @transactions = []
  end

  def add_book(book)
    validate_book_uniqueness(book)
    @books << book
    book
  end

  def add_member(member)
    raise ValidationError, "Invalid member object" unless member.is_a?(Member)
    raise DuplicateBookError, "Member with email #{member.email} already exists" if member_exists?(member.email)
    
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
    query = query.downcase
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
    transaction = member.borrow_book(book)
    @transactions << transaction
    transaction
  end

  def process_return(member_id:, book_id:)
    member = find_member(member_id)
    book = find_book(book_id)
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

  private

  def book_exists?(isbn)
    @books.any? { |book| book.isbn == isbn }
  end

  def member_exists?(email)
    @members.any? { |member| member.email == email }
  end

  def find_book(book_id)
    @books.find { |b| b.id == book_id } || raise(LibraryError, "Book not found")
  end

  def find_member(member_id)
    @members.find { |m| m.id == member_id } || raise(LibraryError, "Member not found")
  end

  def find_transaction(book, member)
    @transactions.find { |t| t.book == book && t.member == member && !t.returned? } ||
      raise(LibraryError, "Transaction not found")
  end

  def validate_book_uniqueness(book)
    raise LibraryError, "Book with ISBN already exists" if @books.any? { |b| b.isbn == book.isbn }
  end

  def validate_member_uniqueness(member)
    raise LibraryError, "Member with email already exists" if @members.any? { |m| m.email == member.email }
  end
end 