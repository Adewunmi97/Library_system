class Transaction
    attr_reader :id, :book, :member, :checkout_date, :due_date, :return_date

    LATE_FEE = 50.00

    def initialize(book:, member:)
    @id = generate_unique_id
    @book = book
    @member = member
    @checkout_date = Time.now
    @due_date = calculate_due_date
    @return_date = nil
    end

    def calculate_late_fees
        overdue = ((@return_date || Time.now) - @due_date).to_i/(60 * 60 * 24)
    end

    private
    
    def calculate_due_date
        @checkout_date + (14 * 24 * 60 * 60)
    end
   end
   