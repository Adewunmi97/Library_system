require 'securerandom'

class Book
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


    private


    def generate_unique_id
    uuid = SecureRandom.uuid
    uuid 
    end
   end