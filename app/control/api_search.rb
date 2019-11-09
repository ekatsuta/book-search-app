def search_for_book(book)
  query = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{book}")
  result = JSON.parse(query)
  books = result["items"]
  if result["totalItems"] == 0
    puts "Sorry, we have no record of this book. Please try again..."
    search_for_book_option
  else
    system "clear"
    books = books[0...5]
    @book_hashes = []
    book_result = books.each_with_index do |book, index|
      new_index = index + 1
      puts "Book index: #{new_index}"
      book_hash = get_book_info(book, new_index)
      @book_hashes << book_hash
      show_book(book_hash)
      puts"*********************************"
    end
  end
end

def get_book_info(book, index)
  book_hash = {}
  book_hash[:index] = index
  title = book["volumeInfo"]["title"]
  author = book["volumeInfo"]["authors"]
  publishing_company = book["volumeInfo"]["publisher"]
  if title
    book_hash[:title] = title
  else
    book_hash[:title] = "No title defined for this book"
  end

  if author
    book_hash[:author] = author.join(" & ")
  else
    book_hash[:author] = "No author for this book"
  end

  if publishing_company
    book_hash[:publishing_company] = publishing_company
  else
    book_hash[:publishing_company] = "No publishing company defined for this book"
  end
  book_hash
end

def find_book_by_index(index)
  @book_hashes.find do |book|
    if book[:index] == index
      book
    end
  end
end
