require 'spec_helper'

RSpec.describe LibrarySystem::Book do
  include LibrarySystem

  let(:valid_book) { 
    LibrarySystem::Book.new(
      title: "Ruby Programming", 
      author: "John Doe", 
      isbn: "123-456-789"
    ) 
  }

  describe "#initialize" do
    it "creates a new book with valid attributes" do
      expect(valid_book.title).to eq("Ruby Programming")
      expect(valid_book.author).to eq("John Doe")
      expect(valid_book.isbn).to eq("123-456-789")
      expect(valid_book.status).to eq("available")
    end

    it "raises error with invalid ISBN" do
      expect {
        LibrarySystem::Book.new(
          title: "Ruby", 
          author: "John", 
          isbn: "invalid"
        )
      }.to raise_error(LibrarySystem::ValidationError, "Invalid ISBN format")
    end
  end

  describe "#checkout!" do
    it "changes status to borrowed" do
      valid_book.checkout!
      expect(valid_book.status).to eq("borrowed")
    end

    it "raises error if already borrowed" do
      valid_book.checkout!
      expect { valid_book.checkout! }.to raise_error(
        LibrarySystem::BookError, 
        "Book is not available for checkout"
      )
    end
  end
end 