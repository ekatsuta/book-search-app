class Application

  # Type in a query and display a list of 5 books matching that query.
  # Each item in the list should include the book's author, title, and publishing company.
  # A user should be able to select a book from the five displayed to save to a “Reading List”
  # View a “Reading List” with all the books the user has selected from their queries -- this is a local reading list and not tied to Google Books’s account features.

  def run
    welcome
  end

  def welcome
    puts "Welcome!"
    puts "*********************************"
    puts "What is your name?"
    puts "*********************************"
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
  end

end
