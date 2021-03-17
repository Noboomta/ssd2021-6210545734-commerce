class Article < ApplicationRecord

    has_many :comments
  
    validates :body, length: { minimum: 4 }
    validate :no_bad_words_in_title
  
    def no_bad_words_in_title
      if title.downcase.include?('bad')
        errors.add(:title, 'cannot contain bad words')
      end
    end
  end