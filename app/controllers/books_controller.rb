class BooksController < ApplicationController
  def index
    @pagy, @books = pagy Book.available, items: Settings.pagy.items_12
  end
end
