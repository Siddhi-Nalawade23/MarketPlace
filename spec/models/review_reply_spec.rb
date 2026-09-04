require "rails_helper"

RSpec.describe ReviewReply, type: :model do
    it "belongs to review" do
        association=ReviewReply.reflect_on_association(:review)
        expect(association.macro).to eq(:belongs_to)
    end
    it "belongs to seller" do
        association=ReviewReply.reflect_on_association(:seller)
        expect(association.macro).to eq(:belongs_to)
    end
    it "it in invalid without comment" do
        reviewreply=ReviewReply.new(comment: nil)
        expect(reviewreply).to be_invalid
    end
end
