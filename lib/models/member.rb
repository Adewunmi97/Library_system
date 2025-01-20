require 'securerandom'
require_relative '../concerns/id_module'
require_relative '../errors/custom_errors'

module LibrarySystem
  class Member
    include IDGenerator
    include Errors

    VALID_STATUSES = %w[active suspended terminated].freeze
    MAX_BORROWED_BOOKS = 5

    attr_accessor :name, :email, :membership_status
    attr_reader :id, :borrowed_books, :created_at

    def initialize(name:, email:)
      @id = generate_unique_id
      @name = name
      @email = email
      @membership_status = "active"
      @borrowed_books = []
      @created_at = Time.now
      validate_member_data
    end

    def active?
      @membership_status == "active"
    end

    def update_status(new_status)
      raise ValidationError, "Invalid status: #{new_status}" unless VALID_STATUSES.include?(new_status)
      @membership_status = new_status
    end

    def borrow_book(book)
      raise MemberError, "Member is not active" unless active?
      raise BookError, "Book is not available" unless book.available?
      
      book.checkout!
      @borrowed_books << book
      Transaction.new(book: book, member: self)
    end

    def return_book(book)
      raise MemberError, "Book not borrowed by this member" unless borrowed_books.include?(book)
      
      book.return!
      @borrowed_books.delete(book)
    end

    private

    def validate_member_data
      raise ValidationError, "Name cannot be empty" if name.to_s.strip.empty?
      raise ValidationError, "Invalid email format" unless valid_email?
    end

    def valid_email?
      email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    end
  end
end 