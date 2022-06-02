*** Settings ***
Documentation  Login to page.
Library  Selenium2Library
Variables   ../config.py

*** Variables ***
${username}    id:email
${password}    id:password
${btn}   id:login
${wks}  id:workspace_recent_workShare_item_0
${wks_search}    id:workspace_filterBar_searchInput

${USER_EMAIL}   minhngoccnter@gmail.com
${USER_PASSWORD}    admin

#production
${APP_URL}  https://app.eofactory.ai
${LOGIN_URL}    https://eofactory.ai/signIn.html?redirect=${APP_URL}/authentication?token=
${WKS_ID}       03bab128-da6d-4632-801d-75c6708fe8b1
${WKS_NAME}     Test bug

#test
#${APP_URL}  https://apptest.eofactory.ai:3444/
#${LOGIN_URL}    https://test.eofactory.ai:3443/signIn.html/?redirect=${APP_URL}/authentication?token=
#${WKS_NAME}     MinhNgoc

${HEADLESS_BROWSER}    0

*** Keywords ***

Init Browser Instance
    IF    ${HEADLESS_BROWSER} == 0
        Open Browser	${LOGIN_URL}	chrome
    ELSE
        ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
        Call Method    ${chrome_options}    add_argument    test-type
        Call Method    ${chrome_options}    add_argument    --disable-extensions
        Call Method    ${chrome_options}    add_argument    --headless
        Call Method    ${chrome_options}    add_argument    --disable-gpu
        Call Method    ${chrome_options}    add_argument    --no-sandbox
        Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
        Create Webdriver    Chrome    chrome_options=${chrome_options}
        Go To          ${LOGIN_URL}
    END

Open Workspace
    wait until element is visible  ${wks}   20
    click element   ${wks}

Login To Page And Open Workspace
    Init Browser Instance
    wait until element is visible  ${username}  5
    maximize browser window
    input text  ${username}  ${USER_EMAIL}
    input text  ${password}  ${USER_PASSWORD}
    click button  ${btn}
    Open Workspace




