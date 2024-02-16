*** Settings ***
Documentation        Suite de teste de cadastro de dog walker

Resource    ../resources/base.resource

Test Setup        Start session
Test Teardown     Finish session


*** Test Cases ***
Deve poder cadastrar um novo dog walker
    [Tags]    smoke

    # MASSA DE TESTE
    # DICIONÁRIO = SUPER VARIÁVEL
    ${dog_walker}      Create Dictionary    
    ...    nome=Pedro Henrique
    ...    e-mail=pedro@gmail.com
    ...    cpf=67568052583
    ...    cep=06328020 
    ...    rua=Avenida Pilar do Sul 
    ...    bairro=Conjunto Habitacional Presidente Castelo Branco
    ...    cidade/uf=Carapicuíba/SP 
    ...    numero=250 
    ...    complemento=Apto 45
    ...    cnh=toretto.jpg


    # ENCAPSULAMENTO DE PALAVRAS CHAVES PARA REUSO
    Go to signup page
    Fill signup form    ${dog_walker}
    Sleep    5
    Submit singup form
    Popup should be     Recebemos o seu cadastro e em breve retornaremos o contato.


Não deve cadastrar se os campos obrigatórios não forem preenchidos
    [Tags]    required
    Go to signup page
    Submit singup form
    
    Alert should be    Informe o seu nome completo
    Alert should be    Informe o seu melhor email
    Alert should be    Informe o seu CPF
    Alert should be    Informe o seu CEP
    Alert should be    Informe um número maior que zero
    Alert should be    Adcione um documento com foto (RG ou CHN)



Não deve cadastrar se o CPF for incorreto
    [Tags]    cpf_inv

    ${dog_walker}      Create Dictionary    
    ...    nome=Pedro Henrique
    ...    e-mail=pedro@gmail.com
    ...    cpf=6756805251a
    ...    cep=06328020 
    ...    rua=Avenida Pilar do Sul 
    ...    bairro=Conjunto Habitacional Presidente Castelo Branco
    ...    cidade/uf=Carapicuíba/SP 
    ...    numero=250 
    ...    complemento=Apto 45
    ...    cnh=toretto.jpg

    Go to signup page
    Fill signup form       ${dog_walker}
    Sleep                  5
    Submit singup form
    Alert should be        CPF inválido



Deve poder cadastrar um novo dog walker que sabe cuidar de pets
    [Tags]    aservice

    ${dog_walker}      Create Dictionary    
    ...    nome=Toretto Pedro
    ...    e-mail=torettopedro@gmail.com
    ...    cpf=67568052583
    ...    cep=06328020 
    ...    rua=Avenida Pilar do Sul 
    ...    bairro=Conjunto Habitacional Presidente Castelo Branco
    ...    cidade/uf=Carapicuíba/SP 
    ...    numero=250 
    ...    complemento=Apto 45
    ...    cnh=toretto.jpg

    Go to signup page
    Fill signup form    ${dog_walker}
    Additional Service    Cuidar
    Submit singup form
    Popup should be     Recebemos o seu cadastro e em breve retornaremos o contato.

    
Deve poder cadastrar um novo dog walker que sabe adestrar pets
    [Tags]    aservice

    ${dog_walker}      Create Dictionary    
    ...    nome=Toretto Henrique
    ...    e-mail=torettohenrique@gmail.com
    ...    cpf=67568052583
    ...    cep=06328020 
    ...    rua=Avenida Pilar do Sul 
    ...    bairro=Conjunto Habitacional Presidente Castelo Branco
    ...    cidade/uf=Carapicuíba/SP 
    ...    numero=250 
    ...    complemento=Apto 45
    ...    cnh=toretto.jpg

    Go to signup page
    Fill signup form    ${dog_walker}
    Additional Service    Adestrar
    Submit singup form
    Popup should be     Recebemos o seu cadastro e em breve retornaremos o contato.







# SESSÃO DE PALAVRAS CHAVES
#*** Keywords ***    

# # CHECK POINTS - VERIFICANDO SE É A PÁGINA CORRETA
# Go to signup page
#     New Browser                browser=chromium    headless=False
#     New Page                   https://walkdog.vercel.app/signup

#     # PALAVRA CHAVE DE CHECK POINT -> WAIT FOR ELEMENTS STATE
#     Wait For Elements State    form h1    visible    5000
#     Get Text                   form h1    equal    Faça seu cadastro


# Fill signup form
#     [Arguments]    ${dog_walker}
#                                # PROPRIEDADE HTML PARA LOCALIZAR O ELEMENTO
#     Fill Text                  css=input[name=name]                 ${dog_walker}[nome]
#     Fill Text                  css=input[name=email]                ${dog_walker}[e-mail]  
#     Fill Text                  css=input[name=cpf]                  ${dog_walker}[cpf]
#     Fill Text                  css=input[name=cep]                  ${dog_walker}[cep]

#     Click                      css=input[type=button][value$=CEP]

#     # VALIDANDO O CEP CORRETO
#     Get Property               css=input[name=addressStreet]          value    equal    ${dog_walker}[rua]
#     Get Property               css=input[name=addressDistrict]        value    equal    ${dog_walker}[bairro]
#     Get Property               css=input[name=addressCityUf]          value    equal    ${dog_walker}[cidade/uf]

#     Fill Text                  css=input[name=addressNumber]        ${dog_walker}[numero]
#     Fill Text                  css=input[name=addressDetails]       ${dog_walker}[complemento]

#     Upload File By Selector    input[type=file]                     ${EXECDIR}/${dog_walker}[cnh]


# Submit singup form
#     Click                      css=.button-register


# Popup should be
#     [Arguments]                ${expected_text}
#     Wait For Elements State    css=.swal2-html-container            visible    5
#     Get Text                   css=.swal2-html-container            equal      ${expected_text}