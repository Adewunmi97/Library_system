class MemberService
  def initialize(library)
    @library = library
  end

  def register_member(name:, email:)
    member = Member.new(name: name, email: email)
    @library.add_member(member)
  end

  def process_checkout(member_id:, book_id:)
    @library.process_checkout(member_id: member_id, book_id: book_id)
  end

  def process_return(member_id:, book_id:)
    @library.process_return(member_id: member_id, book_id: book_id)
  end
end 