Feature: The following are a list of scenarios that verify that the build of the Macy's Ecommerce website is testable before the build is released into the of the QA Teams

@1367
Scenario Outline:
Given I am in MCOM site
And I have 0 items in my shopping bag
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "<fromValue>" to "<toValue>" numbering "<quantity>"
And I navigate to the shopping bag page
Then I should see the "shopping bag "
Then I should verify the "<quantity>" number of product is in shopping bag

Examples:
|fromValue|toValue|quantity|
|0|700|1|

@1368
Scenario: Facets verification

Given I am in MCOM site
Then I select a menu randomly
And I select a random submenu 
And I verify the submenu
Then I select the facet and verify it

@1366
Scenario: As An Automated Script, When I Go To The Newly Deployed Website, I Am Able To Navigate To a PDP page 

Given I go for the MCOM site
When I open the given url for verifying the product
Then I should be able to verify the product type
When I open another given url for verifying the product
Then I should be able to verify the product type

@1362
Scenario: As An Automated Script, When I Go To The Newly Deployed Website, I verify that i'm on home page

Given I am in MCOM site
Then I verify the MCOM site

@credit_services
Scenario: Access Contact credit services Page
Given I am in MCOM site
	And I visit to customer service page
	Then I am on the "customer service" page
	Then I verify the URL

@1392
Scenario: Registry FOB Navigation
Given I am in MCOM site
And I get all top level category into a list
Then I click on wedding registry link
And I get all top level category into a list
And I compare both lists
Then I verify display

@1365
Scenario Outline:  As a customer, When I visit a catalog browse page, I should see a list of products
Given I am in MCOM site
	And I have categories available to select
Then I select a menu randomly
And I select a random submenu 
And I verify the submenu
	Then I select the facet and verify it
Then I should see a list of products

Examples:
	| Test_Run	|
	| 1			|
	| 2			|
	| 3			|
	| 4			|
	| 5			|
	
@1391
Scenario: BVR Checkout

Given I go for the MCOM site
And Navigate to Macy's Wedding Registry Page
And I click on Create Register button
When I enter the Email Address and password "username3" and "password3" details
Then I click on CREATE REGISTRY button
And I purchase "No_itemtoReg" registry items
When From My Registry page, add "No_itemtobag" items from registry to bag
And Click on Continue Checkout button
And I verify the Registrant and shipment details
And Click on Checkout Option from shopping bag page
And Click on Continue Checkout button
When I entered security code as "code" in payment details page
Then Click on Continue Checkout button
And verify review your shipments page

@SearchReg
Scenario: Search Couples Registry.
Given I go for the MCOM site

When Navigate to Macy's Wedding Registry Page
And Search for an existing couple's registry as "registry_fn1" and "registry_ln1" who has selected the go green option
Then Verify that successfully locate couple in Find Results
And I click on view registry link   

@CreateProfile
Scenario: Create Profile

Given I am in MCOM site
When I click on the "sign in" link
And I create a profile
Then I enter profile details
And Navigate to "my macy's account" page
Then I click on SignOut button
When I click on the "sign in" link
Then Navigate to "sign in" page
And Give vaild new Username and Password details


@1388
Scenario: Facets verification in currentCategory class

Given I am in MCOM site
Then I select a menu randomly
And I select a random submenu 
And I verify the submenu
Then I select the facet and verify it

@ExpressCheckout
Scenario: Express Checkout

Given I am in MCOM site
	When I click on the "sign in" link
	Then I click "sign in" link
	When I create a profile
	When I enter profile details
	Then I click "My Wallet" link
	And I enter credit card information
	Then I see text "Your Wallet entry was successfully saved"
	Then I click "My Address Book" link
	And I enter add address
	Then I see text "Your entry has been successfully saved"	
	And I select "random" from the navigation menu
	When I select the category "random"
	Then I should see the current category
	When I select any item from collection
	And I add item 1 to bag
	Then I click on checkout button
	And I click express checkout button
	Then I am on the "review" page
	And I enter security code
	And I click place order
	Then I see order number
	
@checkoutwithoutprofile
Scenario: Order Number Generated or not
Given I am in MCOM site
    And I select "random" from the navigation menu
	When I select the category "random"
	Then I should see the current category
	When I select any item from collection
	And I add item 1 to bag
	Then I see text "1 item added to your bag"
	Then I click on checkout button
	When I click continuecheckout
	When I choose checkout without profile
	Then I am on the "shipping address" page
	When I enter shipping details
	And I continue checkout again
	Then I am on the "Choose Shipping Options" page
	When I continue checkout again
	Then I am on the "enter payment information" page
	When I enter credit card details
    And I enter billing address
    And I continue checkout again
	Then I am on the "review" page
	And I click place order
	Then I see order number  
	
@UpdateReg
Scenario: Update the existing Registry information

Given I go for the MCOM site
When I click on SignIn
Then Navigate to "sign in" page
And I give vaild credentials "username3" and "password3"
And Navigate to Macy's Wedding Registry Page
And I click on Update in Registry Manager page
And I click Edit Account link in BVR page
And I update the Registrant information
And I click Edit Account link in BVR page
Then I verify the updated information   

@create_reg
Scenario: Create new registry and check whether its created

Given I go for the MCOM site
When I click on the WEDDING REGISTRY link
And I click on Create Registry
When I enter the necessary credentials to create new registry
And I enter the other details to create new registry
Then I check the registry is created or not   

@Add_cardtoProfile
Scenario: Adding a card to a profile

Given I am in MCOM site
When I click on the "sign in" link
Then I click "sign in" link
When I create a profile
And I enter user Create user details and Credit Card details for a new user
And I click "Macy's Credit Card" link
When I click "Credit Account Summary" link
Then I verify the credit card details has been entered correctly