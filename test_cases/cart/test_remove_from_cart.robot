*** Settings ***
Library    SeleniumLibrary
Resource   ../../resources/locators.robot
Resource   ../../resources/variables.robot

*** Test Cases ***
Test Remove Product from Cart
    [Setup]    Open Browser    ${URL}    ${BROWSER}
    [Teardown]    Close Browser
    Wait Until Element Is Visible    ${BTN_REMOVE_FROM_CART}
    Click Button    ${BTN_REMOVE_FROM_CART}
    Sleep    2s
    Page Should Contain    Add to cart