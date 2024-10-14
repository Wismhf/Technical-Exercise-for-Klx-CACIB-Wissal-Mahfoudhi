*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            http://automationexercise.com
${USERNAME}       autexercise@email.com
${PASSWORD}       testpass

*** Test Cases ***
Confirm an Order
    [Documentation]    Navigate to a shopping site and confirm an order
    [Setup]   Navigate to the Shopping Site
    Go To Products Page
    Search for Shirts
    Check if products are visible
    Add Products to card
    Go To card Page and check products
    Click To Proceed to shopping button
    Sign in to Proceed to Shooping
    Proceed To Shooping and Press the button Place order
    Fill Card Information
    Submit the Order and Verify it is confirmed
    [Teardown]   Close Browser
*** Keywords ***
Navigate to the Shopping Site
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Go To    ${URL}
    Log    Navigate to URL
Go To Products Page    
    Click Link    //a[text()=' Products']
    Log    Navigate to Products page
Search for Shirts
    Input Text    //input[@id='search_product']    shirts
    Click Button    //button[@id='submit_search']
    Log    Search for Shirts
Check if products are visible     
    ${products_visible}=    Element Should Be Visible    //div/h2[text()='Searched Products']
    Log    Products are visible
Add Products to card
    Click Element    (//a[contains(@class, 'btn') and contains(text(), 'Add to cart')])[1]
    Reload Page
    Click Element    (//a[contains(@class, 'btn') and contains(text(), 'Add to cart')])[1]
    Log    Elements are added to card
Go To card Page and check products    
    Click Link    //ul/li[3]/a
    ${cart_visible}=    Element Should Be Visible    //table/thead/tr[@class='cart_menu']
    Log    Cart products is shown

Click To Proceed to shopping button
    Click Element    //div[@class='row']/div/a
    
Sign in to Proceed to Shooping
    Click Link    //p/a
    Input Text    //input[@name='email']    ${USERNAME}
    Input Text    //input[@name='password']    ${PASSWORD}
    Click Button    //button[@data-qa='login-button']
    ${user_visible}=    Element Should Be Visible    //ul[@class='nav navbar-nav']/li[10]/a
    Log    User is logged in
    Sleep     3
    
Proceed To Shooping and Press the button Place order
    Click Link    //ul/li[3]/a
    Sleep     3
    Click Element    //div[@class='row']/div/a
    ${List_products_visible}=    Element Should Be Visible    //table/thead/tr[@class='cart_menu']
    Log    The products are visible in the checkout list
    Click Element    //div[@class='container']/div[7]/a
    Log    The button place order is clicked
    
Fill Card Information
    
    Input Text    //input[@name='name_on_card']    Autoexercice_user
    Input Text    //input[@name='card_number']    9123445677
    Input Text    //input[@name='cvc']    123
    Input Text    //input[@name='expiry_month']    12
    Input Text    //input[@name='expiry_year']    25
    
Submit the Order and Verify it is confirmed
    Click Button    //button[@id='submit']
    Wait Until Element Contains    //*[@id='form']/div/div/div/p    Congratulations! Your order has been confirmed!    
    Log    Order is confirmed
    
    
