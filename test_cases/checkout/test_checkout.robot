*** Settings ***
Library    SeleniumLibrary
Resource   ../../resources/locators.robot
Resource   ../../resources/variables.robot

*** Test Cases ***
Test Checkout
    [Setup]    Open Browser    ${URL}    ${BROWSER}
    [Teardown]    Close Browser
    Wait Until Element Is Visible    ${BTN_CHECKOUT}
    Click Button    ${BTN_CHECKOUT}
    Sleep    2s
    Page Should Contain    Thank you for your order!
