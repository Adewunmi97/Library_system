require 'securerandom'
require_relative '../concerns/id_module'
require_relative '../errors/custom_errors'

module LibrarySystem
  class Book
    include IDGenerator

    VALID_STATUSES = %w[available borrowed reserved].freeze

    attr_accessor :title, :author, :isbn, :status
    attr_reader :id, :created_at

    def initialize(title:, author:, isbn:)
      @id = generate_unique_id
      @title = title.to_s.strip
      @author = author.to_s.strip
      @isbn = isbn.to_s.strip
      @status = "available"
      @created_at = Time.now
      validate_book_data
    end
  
    def available?
      status == "available"
    end

    def borrowed?
      status == "borrowed"
    end

    def reserved?
      status == "reserved"
    end

    def update_status(new_status)
      raise ValidationError, "Invalid status: #{new_status}" unless VALID_STATUSES.include?(new_status)
      self.status = new_status
    end

    def checkout!
      raise BookError, "Book is not available for checkout" unless available?
      update_status("borrowed")
    end

    def return!
      raise BookError, "Book is already available" if available?
      update_status("available")
    end

    private

    def validate_book_data
      raise ValidationError, "Title cannot be empty" if title.empty?
      raise ValidationError, "Author cannot be empty" if author.empty?
      raise ValidationError, "Invalid ISBN format" unless valid_isbn?
    end

    def valid_isbn?
      isbn.match?(/^\d{3}-\d{3}-\d{3}$/)
    end
  end
end 