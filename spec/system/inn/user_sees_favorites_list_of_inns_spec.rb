require 'rails_helper'

describe 'User sees a list of his favorites inns' do
  it 'with success' do 
    owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    owner2 = InnOwner.create!(email: 'leandro2@email.com', password: '123456', first_name: 'Leandro2', last_name: 'Carvalho2', document: '07230578000')
    owner3 = InnOwner.create!(email: 'leandro3@email.com', password: '123456', first_name: 'Leandro3', last_name: 'Carvalho3', document: '91100223096')
    
    owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
        address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    list = owner.lists.create!(name: "Lista de Verão")

    list.inns.create!(name: 'Pousada dos Devs', inn_owner: owner2, registration_number: '97138572000173', description: 'Um bom lugar', 
    address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    list.inns.create!(name: 'Recanto dos Rubistas', inn_owner: owner3, registration_number: '08397842000130', description: 'Um bom lugar', 
    address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as owner
    visit root_path

    click_on 'Listas'
    click_on "Lista de Verão"
    
    expect(page).to have_content 'Pousada dos Devs'
    expect(page).to have_content 'Recanto dos Rubistas'
    expect(page).not_to have_content 'Pousada do Almeidinha'
    
  end
end