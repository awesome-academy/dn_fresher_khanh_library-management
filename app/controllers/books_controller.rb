class BooksController < ApplicationController
  authorize_resource

  def index
    @pagy, @books = pagy Book.available, items: Settings.pagy.books_items
  end
end
