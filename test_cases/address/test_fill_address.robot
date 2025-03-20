*** Settings ***
Library    SeleniumLibrary
Resource   ../../resources/locators.robot
Resource   ../../resources/variables.robot

*** Test Cases ***
Test Fill Address
    [Setup]    Open Browser    ${URL}    ${BROWSER}
    [Teardown]    Close Browser
    Wait Until Element Is Visible    ${TXT_ADDRESS}
    Input Text    ${TXT_ADDRESS}    123 Main St, Anytown, USA
    Sleep    2s
    Page Should Contain    123 Main St, Anytown, USA
