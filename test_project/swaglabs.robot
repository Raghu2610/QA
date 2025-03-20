*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    String

*** Variables ***
${URL}    https://www.saucedemo.com/?ref=hackernoon.com
${BROWSER}    Chrome
${PASSWORD}    secret_sauce
@{VALID_USERNAMES}    standard_user    locked_out_user    problem_user    performance_glitch_user    error_user    visual_user

${CREDENTIALS_FILE}    credentials.csv

*** Test Cases ***
Test Login with Valid Usernames
    FOR    ${username}    IN    @{VALID_USERNAMES}
        Open Browser    ${URL}    ${BROWSER}
        Wait Until Element Is Visible    id=user-name
        Input Text    id=user-name    ${username}
        Input Text    id=password    ${PASSWORD}
        Sleep    4s
        Click Button    id=login-button
        Sleep    4s
        Run Keyword If    '${username}' == 'locked_out_user'    Page Should Contain    Epic sadface: Sorry, this user has been locked out.
        Run Keyword If    '${username}' != 'locked_out_user'    Wait Until Element Is Visible    id=inventory_container
        Sleep    4s
        Close Browser
    END


Test Login with Credentials from CSV
    ${credentials}=    Get Credentials From CSV    ${CREDENTIALS_FILE}
    FOR    ${row}    IN    @{credentials}
        ${username}=    Set Variable    ${row}[username]
        ${password}=    Set Variable    ${row}[password]
        Open Browser    ${URL}    ${BROWSER}
        Wait Until Element Is Visible    id=user-name
        Input Text    id=user-name    ${username}
        Input Text    id=password    ${password}
        Sleep    4s
        Click Button    id=login-button
        Sleep    4s
        Run Keyword If    '${username}' == 'locked_out_user'    Page Should Contain    Epic sadface: Sorry, this user has been locked out.
        Run Keyword If    '${username}' != 'locked_out_user'    Wait Until Element Is Visible    id=inventory_container
        Sleep    4s
        Close Browser
    END

*** Keywords ***
Get Credentials From CSV
    [Arguments]    ${file_path}
    ${data}=    Create List
    ${content}=    Get File    ${file_path}
    ${lines}=    Split To Lines    ${content}
    FOR    ${line}    IN    @{lines}
        ${username}    ${password}=    Split String    ${line}    ,
        ${row}=    Create Dictionary    username=${username}    password=${password}
        Append To List    ${data}    ${row}
    END
    RETURN    ${data}