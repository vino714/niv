Feature: SST Code Release Regression - Registry

@regression
@MCOM-57158
Scenario: Create new registry and check whether its created.
Given I am in MCOM site
When I click on the WEDDING REGISTRY link
And I click on Create Registry
When I enter the necessary credentials to create new registry
And I enter the other details to create new registry
Then I check the registry is created or not

@Regression
@MCOM-56367
Scenario: Search for a Registry couple and purchase off their registry items and non registry items and Ship all to the registrant address in single shipment

Given I go for the MCOM site
When I click on SignIn
Then Navigate to "sign in" page
And I give vaild credentials "username1" and "password1"
And Navigate to Macy's Wedding Registry Page
When Search for an existing couple's registry as "registry_fn1" and "registry_ln1" who has selected the go green option
Then Verify that successfully locate couple in Find Results
And I click on view registry link
When From GVR of the registry, add "No_RegItem1" items from registry to bag
Then Verify that successfully see product in bag
When Add "No_nonRegItem1" non-registry items to bag
Then Click on Checkout Option
And Verify the Express Checkout Option is suppressed in shopping bag page
And Click on Continue Checkout button
And Navigate to "choose shipping address" page 
And Verify that multiple shipping addresses option should be selected by default
And Verify that Registrant address should be suppressed and the message should be displayed
And Verify that Registrant address and registry item should be displayed with registry icon
And Verify that the registrant and co-registrant names both should be displayed
And Verify that link to GVR should be displayed next to Registrants
When I select on Registrant Address option
And Click on Checkout Option from shopping bag page
Then Navigate to "Choose Shipping Options" page
And Verify that Is this order a gift should be set to yes by default
And Verify that Registrant Go Green message should be displayed
When Click on Continue Checkout button
Then Navigate to "choose a payment method" page
When I entered security code as "code" in payment details page
Then Click on Continue Checkout button
And Navigate to "review your order" page

@Regression
@MCOM-56368
Scenario: As a guest, search for a Registry couple and purchase off their registry items and non registry items and Ship Non-registry items to the profile addresses and regitry items to registrant address in Multiple shipment.

Given I go for the MCOM site 
When I click on SignIn
Then Navigate to "sign in" page
And I give vaild credentials "username2" and "password2"
And Navigate to Macy's Wedding Registry Page
When Search for an existing couple's registry as "registry_fn2" and "registry_ln2" who has selected the go green option
Then Verify that successfully locate couple in Find Results
And I click on view registry link
When From GVR of the registry, add "No_RegItem2" items from registry to bag
Then Verify that successfully see product in bag
When Add "No_nonRegItem2" non-registry items to bag
Then Click on Checkout Option
And Verify the Express Checkout Option is suppressed in shopping bag page
And Click on Continue Checkout button
And Navigate to "choose shipping address" page 
And Verify that multiple shipping addresses option should be selected by default
And Verify that Registrant address should be suppressed and the message should be displayed
And Verify that Registrant address and registry item should be displayed with registry icon
And Verify that the registrant and co-registrant names both should be displayed
And Verify that link to GVR should be displayed next to Registrants
And Click on Checkout Option from shopping bag page
When I choose non-registry items from shipping address page
And Click on Continue Checkout button
And I verify by default my own profile address for non-registry items
And Click on Checkout Option from shopping bag page
And I choose non-registry items from shipping option page
And Click on Continue Checkout button
When I choose Registry items from shipping address page
And Click on Continue Checkout button
And I verify by default Registry's address for registry items
And Click on Checkout Option from shopping bag page
And I choose registry items from shipping option page
And Verify that Is this order a gift should be set to yes by default
And Verify that Registrant Go Green message should be displayed
And Click on Continue Checkout button
And verify review your shipments page
And Click on Continue Checkout button
Then Navigate to "choose a payment method" page
When I entered security code as "code" in payment details page
Then Click on Continue Checkout button
And Navigate to "review your order" page


@Regression
@MCOM-56376

Scenario: Sign in registry and purchase items from own registry, items from another registry and adding non-registry items to bag and ship them to registrant and profile address in multiple shipment as registrant

Given I go for the MCOM site
And Navigate to Macy's Wedding Registry Page
And I click on Create Register button
When I enter the Email Address and password "username3" and "password3" details
Then I click on CREATE REGISTRY button
And I purchase "No_RegItem3" registry items
When From My Registry page, add "No_RegtoBag3" items from registry to bag
And I click on Wedding and Gift registry page
When Search for an existing couple's registry as "registry_fn3" and "registry_ln3" who has selected the go green option
Then Verify that successfully locate couple in Find Results
And I click on view registry link
When From GVR of the registry, add "No_searchItem3" items from registry to bag
Then Verify that successfully see product in bag
When Add "No_nonRegItem3" non-registry items to bag
Then Click on Checkout Option
And Verify the Express Checkout Option is suppressed in shopping bag page
And Click on Continue Checkout button
And Navigate to "choose shipping address" page 
And Verify that multiple shipping addresses option should be selected by default
And Click on Checkout Option from shopping bag page
When I choose non-registry items from shipping address page
And Click on Continue Checkout button
And I verify by default my own profile address for non-registry items
And Click on Checkout Option from shopping bag page
And I choose non-registry items from shipping option page
And Click on Continue Checkout button
When I choose Registry items from shipping address page
And Click on Continue Checkout button
And I verify by default Registry's address for registry items
When I check if the shipment link and back to registry are available
And Click on Checkout Option from shopping bag page
And I choose registry items from shipping option page
And Verify that Is this order a gift should be set to yes by default
And Verify that Registrant Go Green message should be displayed
And Click on Continue Checkout button
When I choose registrant items from shipping address page
And Click on Continue Checkout button
And I verify by default my own profile address for Registrant items
When I check if the shipment link and back to registry are available
And Click on Checkout Option from shopping bag page
And I choose Registrant items from shipping option page
And Click on Continue Checkout button
And verify review your shipments page
And Click on Continue Checkout button
Then Navigate to "choose a payment method" page
When I entered security code as "code" in payment details page
Then Click on Continue Checkout button
And Navigate to "review your order" page
