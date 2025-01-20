require 'securerandom'
require_relative '../id_module'
require_relative '../errors/custom_errors'

class Book
  include IDGenerator
  include Errors

  VALID_STATUSES = %w[available borrowed reserved].freeze

  attr_accessor :title, :author, :isbn, :status
  attr_reader :id, :created_at

  def initialize(title:, author:, isbn:)
    @id = generate_unique_id
    @title = title
    @author = author
    @isbn = isbn
    @status = "available"
    @created_at = Time.now
    validate_book_data
  end
  
  def available?
    @status == "available"
  end

  def borrowed?
    @status == "borrowed"
  end

  def reserved?
    @status == "reserved"
  end

  def update_status(new_status)
    raise ValidationError, "Invalid status: #{new_status}" unless VALID_STATUSES.include?(new_status)
    @status = new_status
  end

  def checkout!
    raise BookError, "Book is already checked out" unless available?
    @status = "borrowed"
  end

  def return!
    raise BookError, "Book is already available" if available?
    @status = "available"
  end

  private

  def validate_book_data
    raise ValidationError, "Title cannot be empty" if title.to_s.strip.empty?
    raise ValidationError, "Author cannot be empty" if author.to_s.strip.empty?
    raise ValidationError, "Invalid ISBN format" unless valid_isbn?
  end

  def valid_isbn?
    isbn.to_s.match?(/^\d{3}-\d{3}-\d{3}$/)
  end
end 