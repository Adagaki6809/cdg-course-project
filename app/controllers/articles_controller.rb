# frozen_string_literal: true

# ArticlesController
class ArticlesController < ApplicationController
  def index
    render html: 'hello world'
  end
end
