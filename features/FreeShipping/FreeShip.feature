Feature: SST Code Release Regression - FreeShip

@regression
@MCOM-77000
Scenario Outline: Check for the new shipping fees display in Order summary details of all checkout pages
Given I am in MCOM site
When I click on the "sign in" link
Then I should be able to enter "<username>" and "<password>" & click signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "<fromValue>" to "<toValue>" numbering "<quantity>"
When I navigate to shopping bag then to shippping address page
Then I should see in the order summary "<stdShipCharge>"
And I navigate to Shipping Options page
Then I should see in the order summary "<stdShipCharge>"
And I navigate to the other checkout pages
Then I navigate back to Shippping Options page
And I click the Premium Shipping
Then I should see in the order summary "<premiumShipCharge>"
And I navigate to the other checkout pages
Then I navigate back to Shippping Options page
And I click the Express Shipping
Then I should see in the order summary "<expressShipCharge>"
And I navigate to the other checkout pages

Examples:
|username|password|fromValue|toValue|quantity|stdShipCharge|premiumShipCharge|expressShipCharge|
|vinoth@vinoth.com|123456789|0|99|1|Shipping Charges : $ 9.95|Shipping Charges : $ 19.95|Shipping Charges : $ 29.95|

@regression
@MCOM-77004
Scenario Outline: Verify the new flat fee shipping prices should be displayed in Right Now customer service pages
Given I am in MCOM site
When I click on the "shipping info" link
Then I verify the user is in the "Shipping" page
When I click on the "Shipping Fees" link
Then I verify the user is in the "Shipping Fees" page
And I verify the domestic shipping charges 
And I verify the international shipping charges
When I click on the "Shipping Policy" link
Then I verify the user is in the "Shipping Policy" page
And I verify the domestic shipping charges 
When I click on the "Can I ship to an address outside the United States?" link
Then I verify the user is in the "Can I ship to an address outside the United States?" page
And I verify the Flat free shipping 
When I click on the "Para Ayuda" link
Then I verify the user is in the "Para Ayuda" page
And I click on the Infomacion del envio
And I verify the domestic shipping charges for para ayuda
And I go to home page
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "<username>" and "<password>" & click signin
When I select beauty items menu
And I select a submenu from beauty items menu
Then I select the product between "<fromValue>" and "<toValue>" with "<quantity>" numbers
When I navigate to shopping bag then to shippping address page
When I navigate to shipping options page
When I click on the "Shipping Policy" link
And I should see popup window and verify the charges

Examples:
|username|password|fromValue|toValue|quantity|
|vinoth@vinoth.com|123456789|99|700|1|

@regression
@MCOM-59414
Scenario Outline: Free Shipping and multiple shipping for above $99.00
Given I am in MCOM site 
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "<username>" and "<password>" & click signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "<fromValue>" to "<toValue>" numbering "<quantity>"
When I navigate to shopping bag then to shippping address page
Then I verify the user is in the "choose shipping address" page
And I verify for free shipping
And I click on the multiple address shipping
Then I verify the user is in the "choose items for shipment # 1" page
And I select the item
Then I verify the user is in the "Choose shipping address for shipment # 1" page
And I confirm the address
Then I verify the user is in the "Choose Shipping Options for Shipment # 1" page
And I verify the various shipping options as "<stdShipCharge>", "<premiumShipCharge>", "<expressShipCharge>"
And I select one of the shipping options
Then I verify the user is in the "choose items for shipment # 2" page
And I select the item for shipment #2
Then I verify the user is in the "Choose shipping address for shipment # 2" page
And I select the second address
Then I verify the user is in the "Choose Shipping Options for Shipment # 2" page
And I verify the various shipping options as "<stdShipCharge#2>", "<premiumShipCharge#2>", "<expressShipCharge#2>"
And I select one of the shipping options for shipping#2
Then I verify the user is in the "review your shipments" page
And I click on continue checkout
And I enter the secret code
And I click on continue checkout
Then I verify the user is in the "review your order" page

Examples:
|username|password|fromValue|toValue|quantity|stdShipCharge|premiumShipCharge|expressShipCharge|stdShipCharge#2|premiumShipCharge#2|expressShipCharge#2|
|vinoth@vinoth.com|123456789|99|300|2|6|16|26|6|26|36|

@regression
@MCOM-59415
Scenario Outline: Verify that registered user should be able to see new flat fees for shipping 
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "<username>" and "<password>" & click signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "<fromValue>" to "<toValue>" numbering "<quantity>"
When I navigate to shopping bag then to shippping address page
Then I should see the "choose shipping address"
And I navigates to shipping address page
Then I should find "<freeShipCharge>"
When I navigate to shipping options page
Then I should see "shipping method"
And I should see the standard, premium, express charges
And I navigate to the billing page
Then I should see "Merchandise Total:"

Examples:
|username|password|fromValue|toValue|quantity|freeShipCharge|
|vinoth@vinoth.com|123456789|99|1000|1|Shipping Charges : $ FREE|

@regression
@MCOM-76999
Scenario Outline: Check for the new Shipping fees in shopping bag page & shipping charges tool tip
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "<username>" and "<password>" & click signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "<fromValue>" to "<toValue>" numbering "<quantity>"
And I navigate to the shopping bag page
Then I should see the "shopping bag "
And I verify the estimated shipping
And I click Estimated Shipping link
And I should see a popup for shipping charge
And I verify "<stdShip>" as "<stdShipCost>" is there in overlay
And I check the overlay for "<totEstShip>" as "<totEstShipCost>"
When I click on the "Standard Shipping" link
And I should see a popup window to check shipping charges
And I verify "<range>" rows of Standard Shipping Costs table

Examples:
|username|password|fromValue|toValue|quantity|stdShip|stdShipCost|totEstShip|totEstShipCost|range|
|vinoth@vinoth.com|123456789|0|99|1|Standard Shipping|$9.95|Total Est. Shipping Costs|$9.95|2|

@regression
@MCOM-59419
Scenario Outline: Verify that item level FREE SHIPPING should be applied to the order, if the user has Beauty items in the shopping bag. 
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "<username>" and "<password>" & click signin
When I select beauty items menu
And I select a submenu from beauty items menu
Then I select the product between "<fromValue>" and "<toValue>" with "<quantity>" numbers
And I goto shopping bag page to click estimated shipping
Then I should see "Free Shipping with any $50 Beauty purchase! No promo code required." to checkout all pages

Examples:
|username|password|fromValue|toValue|quantity|
|vinoth@vinoth.com|123456789|50|98|1|

@regression
@MCOM-59413
Scenario Outline: Shipping charges for multiple shipping upto $98.99
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "<username>" and "<password>" & click signin
Then I verify the user is in the "macys" page
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "<fromValue>" to "<toValue>" numbering "<quantity>"
And I navigate to the shopping bag page
Then I should see the "shopping bag "
And I click Estimated Shipping link
And I should see a popup for shipping charge
And I check the overlay for "<totEstShip>" as "<totEstShipCost>"
When I click on the "Standard Shipping" link
And I should see a popup window to check shipping charges
And I verify "<range>" rows of Standard Shipping Costs table
And I continue to checkout
Then I verify the user is in the "choose shipping address" page
Then I should find "<shipCharge>"
And I click on the multiple address shipping
Then I verify the user is in the "choose items for shipment # 1" page
And I select the item
Then I verify the user is in the "Choose shipping address for shipment # 1" page
And I confirm the address
Then I verify the user is in the "Choose Shipping Options for Shipment # 1" page
And I verify the various shipping options as "<stdShipCharge>", "<premiumShipCharge>", "<expressShipCharge>"
And I select one of the shipping options
Then I verify the user is in the "choose items for shipment # 2" page
And I select the item for shipment #2
Then I verify the user is in the "Choose shipping address for shipment # 2" page
And I select the second address
Then I verify the user is in the "Choose Shipping Options for Shipment # 2" page
And I verify the various shipping options as "<stdShipCharge#2>", "<premiumShipCharge#2>", "<expressShipCharge#2>"
And I select one of the shipping options for shipping#2
Then I verify the user is in the "review your shipments" page
And I click on continue checkout
And I enter the secret code
And I click on continue checkout
Then I verify the user is in the "review your order" page

Examples:
|username|password|fromValue|toValue|quantity|totEstShip|totEstShipCost|range|shipCharge|stdShipCharge|premiumShipCharge|expressShipCharge|stdShipCharge#2|premiumShipCharge#2|expressShipCharge#2|
|vinoth@vinoth.com|123456789|0|49|2|Total Est. Shipping Costs|$9.95|3|Shipping Charges : $ 9.95|15.95|25.95|35.95|25.95|35.95|45.95|


@regression
@MCOM-77000
Scenario: Check for the new shipping fees display in Order summary details of all checkout pages
Given I am in MCOM site
When I click on the "sign in" link
Then I should be able to enter "testuser" and "testPassword" & signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "0" to "99" numbering "1"
When I navigate to shopping bag then to shippping address page
Then I verify order summary for "stdShipCharge"
And I navigate to Shipping Options page
Then I verify order summary for "stdShipCharge"
And I navigate to the other checkout pages
Then I navigate back to Shippping Options page
And I click the Premium Shipping
Then I verify order summary for "premiumShipCharge"
And I navigate to the other checkout pages
Then I navigate back to Shippping Options page
And I click the Express Shipping
Then I verify order summary for "expressShipCharge"
And I navigate to the other checkout pages

@demofirst
@demo
@regression
@MCOM-77004
Scenario: Verify the new flat fee shipping prices should be displayed in Right Now customer service pages
Given I am in MCOM site
When I click on the "shipping info" link
Then I verify the user is in the "Shipping" page
When I click on the "Shipping Fees" link
Then I verify the user is in the "Shipping Fees" page
And I verify the domestic shipping charges 
And I verify the international shipping charges
When I click on the "Shipping Policy" link
Then I verify the user is in the "Shipping Policy" page
And I verify the domestic shipping charges 
When I click on the "Can I ship to an address outside the United States?" link
Then I verify the user is in the "Can I ship to an address outside the United States?" page
And I verify the Flat free shipping 
When I click on the "Para Ayuda" link
Then I verify the user is in the "Para Ayuda" page
And I click on the Infomacion del envio
And I verify the domestic shipping charges for para ayuda
And I go to home page
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "testuser" and "testPassword" & signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "99" to "700" numbering "1"
When I navigate to shopping bag then to shippping address page
When I navigate to shipping options page
When I click on the "Shipping Policy" link
And I should see popup window and verify the charges


@regression
@MCOM-59414
Scenario: Free Shipping and multiple shipping for above $99.00
Given I am in MCOM site 
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "testuser" and "testPassword" & signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "99" to "300" numbering "2"
When I navigate to shopping bag then to shippping address page
Then I verify the user is in the "choose shipping address" page
And I verify for free shipping
And I click on the multiple address shipping
Then I verify the user is in the "choose items for shipment # 1" page
And I select the item
Then I verify the user is in the "Choose shipping address for shipment # 1" page
And I confirm the address
Then I verify the user is in the "Choose Shipping Options for Shipment # 1" page
And I verify the various shipping options for "stdMulShipCharge", "premiumMulShipCharge", "expressMulShipCharge"
And I select one of the shipping options
Then I verify the user is in the "choose items for shipment # 2" page
And I select the item for shipment #2
Then I verify the user is in the "Choose shipping address for shipment # 2" page
And I select the second address
Then I verify the user is in the "Choose Shipping Options for Shipment # 2" page
And I verify the various shipping options for "stdMulShipChargeTwo", "premiumMulShipChargeTwo", "expressMulShipChargeTwo"
And I select one of the shipping options for shipping#2
Then I verify the user is in the "review your shipments" page
And I click on continue checkout
And I enter the secret code
And I click on continue checkout
Then I verify the user is in the "review your order" page

@test
@regression
@MCOM-59415
Scenario: Verify that registered user should be able to see new flat fees for shipping 
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "testuser" and "testPassword" & signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "99" to "1000" numbering "1"
When I navigate to shopping bag then to shippping address page
Then I should see the "choose shipping address"
And I navigates to shipping address page
Then I should find "freeShipCharge" in the page
When I navigate to shipping options page
Then I should see "shipping method"
And I should see the standard, premium, express charges
And I navigate to the billing page
Then I should see "Merchandise Total:"

@demosecond
@demo
@regression
@MCOM-76999
Scenario: Check for the new Shipping fees in shopping bag page & shipping charges tool tip
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "testuser" and "testPassword" & signin
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "0" to "49" numbering "1"
And I navigate to the shopping bag page
Then I should see the "shopping bag "
And I verify the estimated shipping
And I click Estimated Shipping link
And I should see a popup for shipping charge
And I verify "stdShip" as "stdShipCost" is in the overlay
And I check the overlay for "totEstShip" as "totEstShipCost" displayed
When I click on the "Standard Shipping" link
And I should see a popup window to check shipping charges
And I verify "2" rows of Standard Shipping Costs table

@demothird
@demo
@regression
@MCOM-59419
Scenario: Verify that item level FREE SHIPPING should be applied to the order, if the user has Beauty items in the shopping bag. 
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "testuser" and "testPassword" & signin
When I select beauty items menu
And I select a submenu from beauty items menu
Then I select the product between "50" and "98" with "1" numbers
And I goto shopping bag page to click estimated shipping
Then I should see "Free Shipping with any $50 Beauty purchase! No promo code required." to checkout all pages


@regression
@MCOM-59413
Scenario: Shipping charges for multiple shipping upto $98.99
Given I am in MCOM site
When I click on the "sign in" link
Then I verify the user is navigated to signin page
Then I should be able to enter "testuser" and "testPassword" & signin
Then I verify the user is in the "macys" page
Then I select a menu randomly
And I select a submenu randomly
And I add products ranging from "0" to "48" numbering "2"
And I navigate to the shopping bag page
Then I should see the "shopping bag "
And I click Estimated Shipping link
And I should see a popup for shipping charge
And I check the overlay for "totEstShip" as "totEstShipCost" displayed
When I click on the "Standard Shipping" link
And I should see a popup window to check shipping charges
And I verify "3" rows of Standard Shipping Costs table
And I continue to checkout
Then I verify the user is in the "choose shipping address" page
Then I should find "stdShipCharge" in the page
And I click on the multiple address shipping
Then I verify the user is in the "choose items for shipment # 1" page
And I select the item
Then I verify the user is in the "Choose shipping address for shipment # 1" page
And I confirm the address
Then I verify the user is in the "Choose Shipping Options for Shipment # 1" page
And I verify the various shipping options for "stdShipMulChargeNoFree", "premiumMulShipChargeNoFree", "expressShipMulChargeNoFree"
And I select one of the shipping options
Then I verify the user is in the "choose items for shipment # 2" page
And I select the item for shipment #2
Then I verify the user is in the "Choose shipping address for shipment # 2" page
And I select the second address
And I verify the various shipping options for "stdShipMulChargeNoFreeTwo", "premiumMulShipChargeNoFreeTwo", "expressShipMulChargeNoFreeTwo"
And I select one of the shipping options for shipping#2
Then I verify the user is in the "review your shipments" page
And I click on continue checkout
And I enter the secret code
And I click on continue checkout
Then I verify the user is in the "review your order" page