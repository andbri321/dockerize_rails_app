require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should have_one(:address).class_name('Address') }
    it { should have_many(:phones).class_name('Phone') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
