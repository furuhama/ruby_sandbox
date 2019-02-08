require 'bundler/inline'

gemfile(true) do
  source 'https://rubygems.org'

  gem 'activerecord', '~> 5.2.0', require: 'active_record'
  gem 'sqlite3', '~> 1.3.0'
  gem 'factory_bot_rails', '5.0.0'
  gem 'rspec'
end

require 'logger'

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Schema.define do
  create_table :books, force: true do |t|
    t.integer :author_id
    t.integer :number
  end

  create_table :authors, force: true do |t|
  end
end

# model definition
class Book < ActiveRecord::Base
  belongs_to :author

  before_validation :called_only_with_create, if: -> { author_id? }

  private

  def called_only_with_create
    self.number += 100
  end
end

class Author < ActiveRecord::Base
end

# factory definition
FactoryBot.define do
  factory :book do
    association :author
    number { 10 }
  end

  factory :author do
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

require 'rspec/autorun'

RSpec.describe 'test case' do
  describe 'with build' do
    subject { book }
    before { book.save }

    let(:book) { build(:book) }

    it { expect(subject.number).to eq 10 }
  end

  describe 'with create' do
    subject { book }

    let(:book) { create(:book) }

    it { expect(subject.number).to eq 110 }
  end
end
