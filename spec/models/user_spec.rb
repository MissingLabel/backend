require 'rails_helper'

describe User do
  let(:joe) { User.new(email: "joe@gmail.com", password: "password", zip_code: 12345) }
  let(:bad_user) { User.new(email: "", password: "", zip_code: 1234456) }

  context "#initialize" do
    it 'should have valid email' do
      joe.save
      expect(joe.email).to eq("joe@gmail.com")
    end

    it 'should have valid password' do
      joe.save
      expect(joe.password).to eq("password")
    end

    it 'should have valid zipcode' do
      joe.save
      expect(joe.zip_code).to eq(12345)
    end

    it 'should be an invalid user object when bad input is given' do
      bad_user.save
      expect(bad_user).to be_invalid
    end
  end
end