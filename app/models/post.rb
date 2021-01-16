class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, through: :users
    accepts_nested_attributes_for :user
end
