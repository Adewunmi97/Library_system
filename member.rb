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
    def borrow_book(book)
    # Implement borrowing logic with validations
    end
    def return_book(book)
    # Implement return logic with validations
    end
   end