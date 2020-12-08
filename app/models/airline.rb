class Airline < ApplicationRecord
    has_many :reviews

    before_create :slugify

    def slugify #replaces spaces with - and .tolowercase
        self.slug = name.parameterize
    end

    def avg_score #quick method that averages our scores
        reviews.average(:score).round(2).to_f #to
    end
end
