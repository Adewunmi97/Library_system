require 'securerandom'
require_relative '../concerns/id_module'
require_relative '../errors/custom_errors'
require_relative 'book'
require_relative 'member'

module LibrarySystem
  class Transaction
    include IDGenerator
    include Errors

    LOAN_PERIOD_DAYS = 14
    DAILY_LATE_FEE = 1.0

    attr_reader :id, :book, :member, :checkout_date, :due_date, :return_date

    def initialize(book:, member:)
      @id = generate_unique_id
      validate_transaction(book, member)
      @book = book
      @member = member
      @checkout_date = Time.now
      @due_date = calculate_due_date
      @return_date = nil
    end

    def complete_return
      @return_date = Time.now
    end

    def returned?
      !@return_date.nil?
    end

    def calculate_late_fee
      return 0.0 if !@return_date || !overdue?
      
      days_late = ((@return_date - @due_date) / 86400).ceil
      days_late * DAILY_LATE_FEE
    end

    private

    def calculate_due_date
      @checkout_date + (LOAN_PERIOD_DAYS * 86400)
    end

    def overdue?
      @return_date > @due_date
    end

    def validate_transaction(book, member)
      raise ValidationError, "Invalid book object" unless book.is_a?(LibrarySystem::Book)
      raise ValidationError, "Invalid member object" unless member.is_a?(LibrarySystem::Member)
    end
  end
end 