require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe 'associations' do
    it { should belongs_to(:perso).class_name('Person') }
  end
end
