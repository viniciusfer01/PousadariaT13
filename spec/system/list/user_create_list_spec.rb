require 'rails_helper'

describe "user creates list" do
  it "succesfully" do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)

    login_as inn_owner
    visit root_path
    click_on 'Adicionar Lista'

    fill_in "Nome",	with: "Favoritos Verão 2025" 
    click_on 'Adicionar'

    puts(current_path)
    expect(page).to have_content 'Lista criada com sucesso.'
    expect(page).to have_content 'Favoritos Verão 2025'
  end

  # teste para usuário n autenticado
  it 'fails with unautheticated user' do

    visit root_path
    click_on 'Adicionar Lista'

    puts(current_path)
    expect(page).not_to have_content 'Cadastrar Nova Lista'
    expect(page).not_to have_content 'Nome'
    expect(page).not_to have_content 'Adicionar'
    
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'  

  end


  # teste para campo obrigatório
  it "fails when there's a missing field" do
    
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
      
      inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
      
      login_as inn_owner
      visit root_path
      click_on 'Adicionar Lista'
      
      click_on 'Adicionar'
      
      puts(current_path)
      expect(page).not_to have_content 'Lista criada com sucesso.'
      expect(page).to have_content 'Nome não pode ficar em branco'
        
  end
end
