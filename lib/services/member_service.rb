module LibrarySystem
  class MemberService
    def initialize(library)
      @library = library
    end

    def register_member(name:, email:)
      member = LibrarySystem::Member.new(name: name, email: email)
      @library.add_member(member)
    end

    def process_checkout(member_id:, book_id:)
      member = @library.find_member(member_id)
      book = @library.find_book(book_id)
      
      raise ValidationError, "Member not found" unless member
      raise ValidationError, "Book not found" unless book
      
      member.borrow_book(book)
      Transaction.new(book: book, member: member)
    end

    def process_return(member_id:, book_id:)
      member = @library.find_member(member_id)
      book = @library.find_book(book_id)
      
      raise ValidationError, "Member not found" unless member
      raise ValidationError, "Book not found" unless book
      
      member.return_book(book)
    end
  end
end 