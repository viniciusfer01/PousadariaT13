require 'rails_helper'

describe 'User adds a inn to his favorites' do 
  it 'Success' do 
    owner1 = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = owner1.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    list1 = owner1.lists.create!(name: 'Lista Verão')
    
    owner2 = InnOwner.create!(email: 'leandro2@email.com', password: '123456', first_name: 'Leandro2', last_name: 'Carvalho2', document: '07230578000')
    inn2 = owner2.create_inn!(name: 'Pousada dos Devs', inn_owner: owner2, registration_number: '97138572000173', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    
    login_as owner1
    visit root_path

    puts page.html

    within("#inn_#{inn2.id}") do
      click_on 'Adicionar aos Favoritos'
    end

    expect(list1.inns).to include(inn2)  
    expect(list1.inns).not_to include(inn)  


  end
end