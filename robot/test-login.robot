*** Settings ***
Library             SeleniumLibrary 
Test Teardown       Capture Page Screenshot
Suite Teardown      Close Browser
*** Variables ***
${URL_HOME}                 http://localhost:8081/#browse/welcome
${BROWSER}                  headlesschrome
${username}                 admin
${password}                 Get File      /opt/admin.password.txt
${DELAY}                    10
${INIT_URL}                 http://localhost:8081
*** Keywords ***
Set Chrome Options
    [Documentation]        Set Chrome options for headless mode
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    [Return]               ${chrome_options}

Open Headless Chrome Browser to Page
    [Arguments]            ${URL}
    ${chrome_options}=     Set Chrome Options
    Create Webdriver       Chrome  chrome_options=${chrome_options}
    Go to                  ${URL_HOME}
Click Login             
    Set Selenium Speed      ${DELAY}
    Click Element           //*[@id="nx-header-signin-1143-btnEl"]
Refresh           
    Click Button            xpath=//*[@id="nx-header-refresh-1130"]    
Input Username and Password
    Input Text              xpath=//*[@id="textfield-1166-inputEl"]         ${username}
    Input Text              xpath=//*[@id="textfield-1167-inputEl"]         ${password}
    # Click Element           xpath=//*[@id="button-1169"]
*** Test Cases ***
Open Home
    Set Chrome Options
    Open Headless Chrome Browser to Page  ${URL_HOME}
Login
    Click Login
    Input Username and Password
    Log to console      ${password}