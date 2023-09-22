require 'rails_helper'

RSpec.describe User, type: :model do
    subject do
      User.new(
        name: 'Pablo',
        user_name: 'PaEzeG',
      )
    end
  before { subject.save }

    it 'Verifies name is not blank' do 
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it 'Verifies username is not blank' do 
        subject.user_name = nil
        expect(subject).to_not be_valid
    end
end