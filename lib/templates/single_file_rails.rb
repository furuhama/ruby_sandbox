# frozen_string_literal: true

require 'bundler/inline'

gemfile(true) do
  source 'https://rubygems.org'

  gem 'activerecord', '~> 5.2.0', require: 'active_record'
  gem 'sqlite3', '~> 1.3.0'
  gem 'rspec'
end

puts "Ruby version: #{RUBY_VERSION}"
puts "Rails version: #{ActiveRecord::VERSION::STRING}"

require 'logger'

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Schema.define do
  create_table :books, force: true do |t|
    t.integer :author_id
    t.string :title
  end

  create_table :authors, force: true do |t|
    t.string :name
  end
end

# model definition
class Book < ActiveRecord::Base
  belongs_to :author
end

class Author < ActiveRecord::Base
  has_many :books
end

require 'rspec/autorun'

RSpec.describe do
  before do
    author = Author.create!(name: 'Stendhal')
    author.books.create!(title: 'Le Rouge et le Noir')
    author.books.create!(title: 'De l\'amour')
  end

  it do
    expect(Author.last.name).to eq 'Stendhal'
    expect(Author.last.books.first.title).to eq 'Le Rouge et le Noir'
    expect(Author.last.books.last.title).to eq 'De l\'amour'
  end
end
