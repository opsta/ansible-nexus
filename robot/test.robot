*** Settings ***
Library             SeleniumLibrary 
*** Variables ***
${URL_HOME}                 http://localhost:8081/#browse/welcome
${BROWSER}                  headlesschrome
${username}                 admin
${password}                 Get Variable Value       /opt/sonatype-work/nexus3/admin.password
${DELAY}                    10
${INIT_URL}                 http://localhost:8081
# ${BROWSER}                  headlessfirefox
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
Open firefox
    Open Browser                        ${INIT_URL}     ${BROWSER}  
Open Loginpage
    Set Selenium Speed      ${DELAY}              
    Click Link            //*[@id="nx-header-signin-1143"]
Home
    Set Selenium Speed      ${DELAY}              
    Click Button            xpath=//*[@id="nx-header-refresh-1130"]    
Input Username and Password
    Input Text              xpath=//*[@id="user_name"]   ${username}
    Input Text              xpath=//*[@id="user_password"]   ${password}
    Click Button            xpath=//*[@id="button-1169"]
*** Test Cases ***
Open Home
    Set Chrome Options
    Open Headless Chrome Browser to Page  ${URL_HOME}
# # Refresh
# #     Home
# Open firefox
#     Open firefox
Click Login
    Open Loginpage
# Input
#     Input Username and Password