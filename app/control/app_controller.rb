def run
  system "clear"
  welcome
rescue SystemExit, Interrupt
  puts "Exiting system"
  exit
rescue StandardError
  exit
end

def welcome
  puts "Welcome! Please enter your name."
  name = gets.chomp.downcase
  if User.find_by(name: name)
    @current_user = User.find_by(name: name)
    system "clear"
    puts "Welcome back #{name}!"
  else
    @current_user = User.create(name: name)
    system "clear"
    puts "Welcome #{name}!"
  end
  menu
end

def menu
  puts"*********************************"
  puts "What would you like to do?"
  puts"*********************************"
  puts "1. Search"
  puts "2. View your reading list"
  puts "3. Exit"
  puts"*********************************"
  task = gets.chomp
  action(task)
end

def action(input)
  case input
    when "1"
      search_for_book_option
    when "2"
      system "clear"
      if @current_user.reload.books.empty?
        puts "You have no books in your reading list"
      end
      display_reading_list
    when "3"
      system "clear"
      puts "Goodbye #{@current_user.name}!"
      exit
    else
      puts "Please enter one of the above index numbers"
      menu
  end
end

def search_for_book_option
  puts "Please type in a search term."
  book_query = gets.chomp
  book = search_for_book(book_query)
  option_to_select
end

def option_to_select
  puts "Please enter one of the index numbers to add a book to your reading list."
  puts "Enter 0 to go back to menu"
  index = gets.chomp.to_i
  if !index.between?(0, 5)
    puts"***************************************"
    puts "Please enter a number between 1 and 5, or 0 to go back to menu"
    puts"***************************************"
    index = gets.chomp.to_i
  elsif index == 0
    system "clear"
    menu
  end
  book = find_book_by_index(index)
  add_book_to_list(book)
end

def add_book_to_list(book)
  book_record = Book.find_by(title: book[:title])
  if book_record
    Favorite.add_new_book(@current_user, book_record)
    menu
  else
    new_book = Book.create(book)
    Favorite.add_new_book(@current_user, new_book)
    system "clear"
    puts "You have added #{new_book.title} to your reading list!"
    back_to_menu_option
  end
end

def show_book(book)
  puts "Title: #{book[:title]}"
  puts "Author: #{book[:author]}"
  puts "Publishing Company: #{book[:publishing_company]}"
end

def back_to_menu_option
  puts "Go back to menu? (y/n)"
  input = gets.chomp
  case input
  when -> result { result.downcase == "yes" || result.downcase == "y" }
    system "clear"
    menu
  when -> result { result.downcase == "no" || result.downcase == "n" }
    system "clear"
    puts "Goodbye #{@current_user.name}!"
    exit
  end
end

def display_reading_list
  books = @current_user.reload.books
    books.each_with_index do |book, index|
      new_index = index + 1
      book.update(index: new_index)
      puts "Book index: #{new_index}"
      show_book(book)
    end
  back_to_menu_option
end
