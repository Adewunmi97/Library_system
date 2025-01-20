require 'spec_helper'

RSpec.describe LibrarySystem::Member do
  let(:member) { LibrarySystem::Member.new(name: "Jane Doe", email: "jane@example.com") }
  let(:book) { LibrarySystem::Book.new(title: "Ruby Programming", author: "John Doe", isbn: "123-456-789") }

  describe "#initialize" do
    it "creates a new member with valid attributes" do
      expect(member.name).to eq("Jane Doe")
      expect(member.email).to eq("jane@example.com")
      expect(member.membership_status).to eq("active")
      expect(member.borrowed_books).to be_empty
    end
  end

  describe "#borrow_book" do
    it "adds book to borrowed_books" do
      member.borrow_book(book)
      expect(member.borrowed_books).to include(book)
    end
  end
end 