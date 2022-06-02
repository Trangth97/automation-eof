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

*** Variables ***
${SUCCESS_NOTIFICATION}  Successful
${authorization}     Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAwMCwibmFtZSI6Ik1pbmggTmfhu41jIiwiZW1haWwiOiJtaW5obmdvY2NudGVyQGdtYWlsLmNvbSIsImNvdW50cnkiOiJWaWV0bmFtIiwicGljdHVyZSI6bnVsbCwiaWF0IjoxNjUyNDI4NTkwLCJleHAiOjE2NTUwMjA1OTB9.ni5i3_HpVZSIn2NzpB3z3FfnoCbo2LVFy-8nHEuyvSUclnapGd-WhKTm50nMvWchlZT7r4xS4aIaI1-xlHr3nQ
${host}     https://api-aws.eofactory.ai

*** Keywords ***
Get CUDIR
    ${cur_dir}  set variable  ${CURDIR}
    [Return]  ${cur_dir}

#---------------Check Task by API Testing-------------------

Append Data to Workbook
    [Arguments]   ${task_id}  ${excel_file}=${CURDIR}/report.xlsx
    open workbook  ${excel_file}
    ${list}=    create list  @{empty}
    append to list  ${list}  ${task_id}
    append rows to worksheet  ${list}
    save workbook