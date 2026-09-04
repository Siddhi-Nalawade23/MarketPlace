require "rails_helper"

RSpec.describe Category, type: :model do
    it "has many products" do
    association=Category.reflect_on_association(:products)
    expect(association.macro).to eq(:has_many)
    end

    it "is invalid without name" do
        category=Category.new(name: nil)
        expect(category).to be_invalid
    end

    it "is valid with name" do
        category=Category.new(name: "electronics",

        )
        expect(category).to be_valid
    end
end
