*** Settings ***
Documentation  Verify Hillshade Tool.
Resource    ../BasePage.robot

*** Variables ***
${name}     hillshade_result
${image}    dem
${z}  2
${s}    2
${az}  320
${alt}     45
${multidirectional}     Multidirectional
${combined}     Combined

*** Test Cases ***
Hillshade With Combined Type
    ${root}     get cudir
    Hillshade API Testing  ${root}/Datas/hillshade_combined.json

*** Keywords ***
Hillshade API Testing
    [Arguments]  ${file_name}
    ${header}=     Create Dictionary    Accept=*/*   Authorization=${authorization}
    ${json}=    Load JSON From File  ${file_name}
    Create Session  hillshade   ${host}  headers=${header}   verify=True
    ${resp}=    post on session  hillshade   url=/api/workspaces/${WKS_ID}/tools   params=group=ard&type=hillshade&region=sea  json=${json}
    append data to workbook  Task ${resp.json()}[data][task_id]



