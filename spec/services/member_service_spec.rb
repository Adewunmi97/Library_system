require 'spec_helper'

RSpec.describe LibrarySystem::MemberService do
  let(:library) { LibrarySystem::Library.new(name: "Test Library") }
  let(:service) { LibrarySystem::MemberService.new(library) }

  describe "#register_member" do
    it "adds a member to the library" do
      service.register_member(
        name: "Jane Doe",
        email: "jane@example.com"
      )
      expect(library.members.length).to eq(1)
    end
  end

  describe "#process_checkout" do
    let(:book) { LibrarySystem::Book.new(title: "Ruby", author: "John", isbn: "123-456-789") }
    let(:member) { LibrarySystem::Member.new(name: "Jane", email: "jane@example.com") }

    before do
      library.add_book(book)
      library.add_member(member)
    end

    it "creates a successful checkout" do
      transaction = service.process_checkout(
        member_id: member.id,
        book_id: book.id
      )
      expect(transaction).to be_a(LibrarySystem::Transaction)
      expect(book.status).to eq("borrowed")
    end
  end
end 