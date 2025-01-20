require_relative 'models/book'
require_relative 'models/member'
require_relative 'models/library'
require_relative 'models/transaction'
require_relative 'errors/custom_errors'

class LibraryCLI
  def initialize
    @library = Library.new(name: "Digital Library")
    @running = true
  end

  def start
    puts "Welcome to the Digital Library Management System"
    
    while @running
      display_menu
      handle_choice(gets.chomp)
    end
  end

  private

  def display_menu
    puts "\nPlease select an option:"
    puts "1. Add Book"
    puts "2. Search Books"
    puts "3. Register Member"
    puts "4. Checkout Book"
    puts "5. Return Book"
    puts "6. Exit"
  end

  def handle_choice(choice)
    case choice
    when "1" then add_book
    when "2" then search_books
    when "3" then register_member
    when "4" then checkout_book
    when "5" then return_book
    when "6" then @running = false
    else
      puts "Invalid choice. Please try again."
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def add_book
    print "Enter title: "
    title = gets.chomp
    print "Enter author: "
    author = gets.chomp
    print "Enter ISBN (format: XXX-XXX-XXX): "
    isbn = gets.chomp

    book = Book.new(title: title, author: author, isbn: isbn)
    @library.add_book(book)
    puts "Book added successfully!"
  end

  def search_books
    print "Enter search term: "
    query = gets.chomp
    books = @library.search_books(query)
    
    if books.empty?
      puts "No books found."
    else
      puts "\nFound books:"
      books.each do |book|
        puts "- #{book.title} by #{book.author} (#{book.status})"
      end
    end
  end

  def register_member
    print "Enter member name: "
    name = gets.chomp
    print "Enter member email: "
    email = gets.chomp

    member = Member.new(name: name, email: email)
    @library.add_member(member)
    puts "Member added successfully!"
  end

  def checkout_book
    list_books
    print "Enter book ID to checkout: "
    book_id = gets.chomp
    
    list_members
    print "Enter member ID: "
    member_id = gets.chomp

    transaction = @library.process_checkout(member_id: member_id, book_id: book_id)
    puts "Book checked out successfully!"
    puts "Due date: #{transaction.due_date.strftime('%Y-%m-%d')}"
  end

  def return_book
    list_members
    print "Enter member ID: "
    member_id = gets.chomp
    
    member = @library.find_member(member_id)
    puts "\nBorrowed books:"
    member.borrowed_books.each do |book|
      puts "ID: #{book.id} - #{book.title}"
    end
    
    print "Enter book ID to return: "
    book_id = gets.chomp

    transaction = @library.process_return(member_id: member_id, book_id: book_id)
    puts "Book returned successfully!"
    late_fee = transaction.calculate_late_fee
    puts "Late fee: $#{late_fee}" if late_fee > 0
  end

  def list_books
    puts "\nLibrary Books:"
    @library.books.each do |book|
      puts "ID: #{book.id}"
      puts "Title: #{book.title}"
      puts "Author: #{book.author}"
      puts "Status: #{book.status}"
      puts "---"
    end
  end

  def list_members
    puts "\nLibrary Members:"
    @library.members.each do |member|
      puts "ID: #{member.id}"
      puts "Name: #{member.name}"
      puts "Email: #{member.email}"
      puts "Status: #{member.membership_status}"
      puts "---"
    end
  end

  def view_member_books
    list_members
    print "Enter member ID: "
    member_id = gets.chomp

    member = @library.members.find { |m| m.id == member_id }
    raise ValidationError, "Member not found" unless member

    if member.borrowed_books.empty?
      puts "No borrowed books."
    else
      puts "\nBorrowed books:"
      member.borrowed_books.each do |book|
        puts "- #{book.title} by #{book.author}"
      end
    end
  end
end

# Start the CLI if this file is run directly
LibraryCLI.new.start if __FILE__ == $PROGRAM_NAME 