class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def self.add_new_book(current_user, book)
    new_favorite = Favorite.create(user_id: current_user.id, book_id: book.id)
    system "clear"
    puts "You have added #{book.title} to your reading list!"
  end

end
