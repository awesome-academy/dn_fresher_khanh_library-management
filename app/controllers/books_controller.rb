class BooksController < ApplicationController
  def index
    @pagy, @books = pagy Book.available, items: Settings.pagy.books_items
  end
end
