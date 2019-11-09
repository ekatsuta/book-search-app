class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def self.add_to_favorites(current_user, book)
    new_favorite = Favorite.create(user_id: current_user.id, book_id: book.id)
  end

end
