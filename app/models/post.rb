class Post < ApplicationRecord
    validates :title, presence: true
    belongs_to :user

    validates :user, presence: true
end