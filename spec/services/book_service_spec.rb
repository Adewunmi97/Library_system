require 'spec_helper'

RSpec.describe LibrarySystem::BookService do
  let(:library) { LibrarySystem::Library.new(name: "Test Library") }
  let(:service) { LibrarySystem::BookService.new(library) }

  describe "#add_book" do
    it "adds a book to the library" do
      service.add_book(
        title: "Ruby Programming",
        author: "John Doe",
        isbn: "123-456-789"
      )
      expect(library.books.length).to eq(1)
    end
  end

  describe "#search_books" do
    before do
      service.add_book(
        title: "Ruby Programming",
        author: "John Doe",
        isbn: "123-456-789"
      )
    end

    it "finds books by title" do
      results = service.search_books("Ruby")
      expect(results.length).to eq(1)
    end
  end
end 