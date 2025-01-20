# Digital Library Management System

A Ruby-based library management system that allows librarians to manage books, members, and transactions efficiently.

## Features

- Book Management
  - Add and remove books
  - Search books by title, author, or ISBN
  - Track book status (available/borrowed/reserved)
  - List all books in the library

- Member Management
  - Register new members
  - Update member information
  - Track borrowed books per member
  - List all library members

- Transaction Handling
  - Process book checkouts
  - Handle returns
  - Calculate late fees
  - Track transaction history


### Available Commands

1. Add Book
   - Add a new book to the library
   - Required: title, author, ISBN (format: XXX-XXX-XXX)

2. Register Member
   - Register a new library member
   - Required: name, email

3. Checkout Book
   - Process book borrowing
   - Required: member ID, book ID

4. Return Book
   - Process book return
   - Required: member ID, book ID

5. Search Books
   - Search books by title, author, or ISBN
   - Shows matching results with status

6. List All Books
   - Display all books in the library
   - Shows book details and current status

7. List All Members
   - Display all registered members
   - Shows member details and borrowed books

## Testing

Run the test suite:
bundle exec rspec


## Error Handling

The system includes robust error handling for:
- Invalid input validation
- Book availability checks
- Member status verification
- Transaction processing
- ISBN format validation
- Email format validation

## Models

### Book
- Attributes: title, author, ISBN, status
- Status types: available, borrowed, reserved
- Validates ISBN format

### Member
- Attributes: name, email, membership status
- Tracks borrowed books
- Validates email format

### Transaction
- Records checkout and return dates
- Calculates late fees
- Tracks book and member information

### Library
- Manages books and members
- Handles search functionality
- Processes checkouts and returns

## Services

### BookService
- Handles book-related operations
- Manages book searches
- Processes book additions

### MemberService
- Handles member registration
- Manages checkouts and returns
- Processes member updates

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Ruby community for best practices and conventions
- RSpec for testing framework
- Contributors and maintainers

## Author

[Your Name]

## Version

1.0.0