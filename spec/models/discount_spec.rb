require 'rails_helper'

RSpec.describe Discount, type: :model do
  include ActiveSupport:: Testing::TimeHelpers

  describe 'validations' do
    it { should validate_presence_of(:percentage) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }

  end

end
