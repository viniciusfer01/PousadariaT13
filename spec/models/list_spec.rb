require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#valid?' do
    context 'when there is an empty field' do
      it 'fails with empty name' do
        inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
        list = List.new(inn_owner: inn_owner)
        
        expect(list).not_to be_valid 
      end

      it 'fails without a owner' do
        list = List.new(name: 'Lista de Verão')
        
        expect(list).not_to be_valid 
      end
    end
    
  end
end
