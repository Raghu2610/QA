*** Settings ***
Library    OperatingSystem
Library    Collections
Library    String

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