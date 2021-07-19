require 'rails_helper'

RSpec.describe User, type: :model do
  current_user = User.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  it "check current_user role is student" do
    expect(current_user.has_role?(:student)).to eql(true)
  end

  it "check current_user role is admin" do
    current_user.add_role(:admin)
    expect(current_user.has_role?(:admin)).to eql(true)
  end

end
