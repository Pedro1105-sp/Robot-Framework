*** Settings ***
Documentation    Arquivo principal do projeto

Library          Browser

Resource         env.resource
Resource         actions/signup.resource

*** Keywords ***
Start session
    New Browser                browser=${BROWSER}    headless=False
    New Page                   https://walkdog.vercel.app

    Wait For Elements State    css=h1 >> text=Cuidado e diversão em cada passo
    ...    visible    5

Finish session
    Take Screenshot    fullPage=True