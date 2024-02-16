*** Settings ***
Documentation    Ações, steps e elementos da funcionalidade de cadastro

Library          Browser

*** Keywords ***

Go to signup page
    Click                      css=a[href="/signup"]

    Wait For Elements State    form h1    visible    5000
    Get Text                   form h1    equal    Faça seu cadastro


Fill signup form
    [Arguments]    ${dog_walker}
    Fill Text                  css=input[name=name]                 ${dog_walker}[nome]
    Fill Text                  css=input[name=email]                ${dog_walker}[e-mail]  
    Fill Text                  css=input[name=cpf]                  ${dog_walker}[cpf]
    Fill Text                  css=input[name=cep]                  ${dog_walker}[cep]

    Click                      css=input[type=button][value$=CEP]

    Get Property               css=input[name=addressStreet]          value    equal    ${dog_walker}[rua]
    Get Property               css=input[name=addressDistrict]        value    equal    ${dog_walker}[bairro]
    Get Property               css=input[name=addressCityUf]          value    equal    ${dog_walker}[cidade/uf]

    Fill Text                  css=input[name=addressNumber]        ${dog_walker}[numero]
    Fill Text                  css=input[name=addressDetails]       ${dog_walker}[complemento]

    Upload File By Selector    input[type=file]                     ${EXECDIR}/resources/fixtures/${dog_walker}[cnh]


Additional Service
    [Arguments]    ${servico_adicional}

    Click                      xpath=//span[text()="${servico_adicional}"]/..
    Take Screenshot            selector=//span[text()="${servico_adicional}"]/..


Submit singup form
    Click                      css=.button-register


Popup should be
    [Arguments]                ${expected_text}
    Wait For Elements State    css=.swal2-html-container            visible    5
    Get Text                   css=.swal2-html-container            equal      ${expected_text}

Alert should be
    [Arguments]                ${expected_text}

    Wait For Elements State    css=.alert-error >> text=${expected_text}
    ...    visible    5