*** Settings ***
Documentation  BasePage contains keywords and locators for page.
Library     Selenium2Library
Library     Collections
Library     String
Library     RequestsLibrary
Library     RPA.Excel.Files
Library     JSONLibrary
Library     OperatingSystem
Library     json
Resource    Login.robot
Variables   BaseLocators.py

*** Variables ***
${SUCCESS_NOTIFICATION}  Successful
${authorization}     Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAwMCwibmFtZSI6Ik1pbmggTmfhu41jIiwiZW1haWwiOiJtaW5obmdvY2NudGVyQGdtYWlsLmNvbSIsImNvdW50cnkiOiJWaWV0bmFtIiwicGljdHVyZSI6bnVsbCwiaWF0IjoxNjUyNDI4NTkwLCJleHAiOjE2NTUwMjA1OTB9.ni5i3_HpVZSIn2NzpB3z3FfnoCbo2LVFy-8nHEuyvSUclnapGd-WhKTm50nMvWchlZT7r4xS4aIaI1-xlHr3nQ
${host}     https://api-aws.eofactory.ai

*** Keywords ***
Get CUDIR
    ${cur_dir}  set variable  ${CURDIR}
    [Return]  ${cur_dir}

Go to Task Menu
    wait until element is visible  ${task_menu}     10
    click element  ${task_menu}

Go to Map Menu
    wait until element is visible  ${map_menu}    20
    click element  ${map_menu}

Go to Imagery Menu
    wait until element is visible  ${imagery_menu}  20
    click element  ${imagery_menu}

Go to Vector Menu
    wait until element is visible  ${vector_menu}    20
    click element  ${vector_menu}

Go to Table Menu
    wait until element is visible  ${table_menu}    20
    click element  ${table_menu}

Go to Model Menu
    wait until element is visible  ${model_menu}    20
    click element  ${model_menu}

Get Task ID from Notification
    ${task_id}=    Check Success Notification
    [Return]  ${task_id}

Confirm Pay Cost
    wait until element is visible  ${pay_cost_button}
    click button  ${pay_cost_button}

Check Success Notification
    wait until element is visible  ${upload_notification_success}  120
    ${notification}     get text  ${upload_notification_success}
    sleep  0.5
    should contain  ${notification}     ${SUCCESS_NOTIFICATION}
    ${noti_split}=  split string  ${notification}    :
    [Return]   ${noti_split}[0]

#---------------Check Task by API Testing-------------------

Append Data to Workbook
    [Arguments]   ${task_id}  ${excel_file}=${CURDIR}/report.xlsx
    open workbook  ${excel_file}
    ${list}=    create list  @{empty}
    append to list  ${list}  ${task_id}
    append rows to worksheet  ${list}
    save workbook

Check Task by API Testing
    [Arguments]  ${excel_file}
    ${task_id}=     get task id from notification
    append data to workbook  ${task_id}     ${excel_file}