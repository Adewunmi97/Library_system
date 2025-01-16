require 'securerandom'
require_relative 'id_module'

class Book
    include IDGenerator

    attr_accessor :title, :author, :isbn, :status
    attr_reader :id, :created_at
    def initialize(title:, author:, isbn:)
    @id = generate_unique_id
    @title = title
    @author = author
    @isbn = isbn
    @status = "available"
    @created_at = Time.now
    end
    
    def available?
        @status == "available"
    end
   end