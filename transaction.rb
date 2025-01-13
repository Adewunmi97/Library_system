class Transaction
    attr_reader :id, :book, :member, :checkout_date, :due_date, :return_date
    def initialize(book:, member:)
    @id = generate_unique_id
    @book = book
    @member = member
    @checkout_date = Time.now
    @due_date = calculate_due_date
    @return_date = nil
    end
    private
    def calculate_due_date
    # Implement due date calculation
    end
   end
   