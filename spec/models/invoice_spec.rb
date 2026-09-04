require "rails_helper"

RSpec.describe Invoice, type: :model do
    it "has belongs to order" do
        association=Invoice.reflect_on_association(:order)
        expect(association.macro).to eq(:belongs_to)
    end
    it "has belongs to seller" do
        association=Invoice.reflect_on_association(:seller)
        expect(association.macro).to eq(:belongs_to)
    end
    it "has belongs to buyer" do
        association=Invoice.reflect_on_association(:buyer)
        expect(association.macro).to eq(:belongs_to)
    end
    it "is invalid when amount is less than 0" do
        invoice=Invoice.new(amount: -2)
        expect(invoice).to be_invalid
    end
     it "is invalid when amount is  0" do
        invoice=Invoice.new(amount: 0)
        expect(invoice).to be_invalid
    end
end
