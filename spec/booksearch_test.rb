require_relative 'spec_helper'

require 'pry'

book = {title: "Harry Potter", author: "J.K. Rowling", publishing_company: "Bloomsbury Publishing‎"}

describe "#action" do
  before do
    @current_user = User.create(name: "Emi")
  end
  it "exits when input is 3" do
    expect { action("3") }.to output(/Goodbye Emi/).to_stdout
  end
end

describe "#show_book" do
  it "shows information on the book object" do
    expect { show_book(book) }
    .to output("Title: Harry Potter\nAuthor: J.K. Rowling\nPublishing Company: Bloomsbury Publishing‎\n")
    .to_stdout
  end
end

describe "#add_book_to_list" do
  it "adds a book" do
    expect { add_book_to_list(book) }
    .to output(/You have added Harry Potter to your reading list!/).to_stdout
  end
end
