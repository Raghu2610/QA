*** Settings ***
Library    SeleniumLibrary
Resource   ../../resources/locators.robot
Resource   ../../resources/keywords.robot
Resource   ../../resources/variables.robot

*** Test Cases ***
Test Login with Credentials from CSV
    [Documentation]    This test case logs in with credentials from a CSV file.
    ${credentials}=    Get Credentials From CSV    ${CREDENTIALS_FILE}
    FOR    ${row}    IN    @{credentials}
        ${username}=    Set Variable    ${row}[username]
        ${password}=    Set Variable    ${row}[password]
        Log    Trying to log in with username: ${username} and password: ${password}
        Open Browser    ${URL}    ${BROWSER}
        Wait Until Element Is Visible    ${TXT_USERNAME}    10s
        Input Text    ${TXT_USERNAME}    ${username}
        Input Text    ${TXT_PASSWORD}    ${password}
        Sleep    4s
        Click Button    ${BTN_LOGIN}
        Sleep    4s
        Run Keyword If    '${username}' == 'locked_out_user'    Page Should Contain    Epic sadface: Sorry, this user has been locked out.
        Run Keyword If    '${username}' != 'locked_out_user'    Wait Until Element Is Visible    ${CONTAINER_INVENTORY}
        Close Browser
        Sleep    4s
    END
