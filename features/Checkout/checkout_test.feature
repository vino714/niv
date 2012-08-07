Feature:  General Tests To Insure That The Checkout Application Is Ready For Testing

@demo
@automated
Scenario:  Place an order with valid Shipping, Payment details and verify order number in Order Confirmation page - Checkout without profile
Given I am on the Macy's home page
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
	And I verify merchandise total
When I enter shipping details
And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
When I enter credit card details
	And I enter billing address
	And I continue checkout again
Then I am on the "review" page
#And I debug_sleep for 33333 seconds

@co_e2e_no_profile
@automated
Scenario:  Place an order with valid Shipping, Payment details and verify order number in Order Confirmation page - Checkout without profile
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#Then I should see "Bed & Bath" as the current category
#When I select the category "Bedding Collections"
When I select any item from collection
	And I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
When I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
When I enter shipping details
And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
When I enter credit card details
	And I enter billing address
	And I continue checkout again
Then I am on the "review" page
#And I debug_sleep for 33333 seconds


@co_to_payment
@automated
Scenario:  Navigate to Payment with Valid Shipping info - without profile
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#When I select the subcategory "random"
When I select any item from collection
	And I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
When I enter shipping details
And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page


@co_to_order_review
@automated
Scenario:  Place an order with valid Shipping, Payment details and verify order number in Order Confirmation page - Checkout without profile
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#When I select the subcategory "random"
When I select any item from collection
	And I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
When I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
When I enter shipping details
When I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
When I enter credit card details
	And I enter billing address
	And I continue checkout again
Then I am on the "review" page


@co_ship_fields_errors
@automated
Scenario:  Verify Shipping page field error validation messages
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#When I select the subcategory "random"
When I select any item from collection
	And I add item 1 to bag
#Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
And I continue checkout again
Then I see text "We're sorry. The fields highlighted below must be completed before we can process your request"
	And I see "firstname" in red color



@co_pay_fields_errors
@automated
Scenario:  Verify Payment page field error validation messages
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#When I select the subcategory "random"
#When I select the first item from collection
When I select any item from collection
	And I add item 1 to bag
#Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
When I enter shipping details
When I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
	And I continue checkout again
	And I see "creditCardType" in red color



@demo
@co_e2e_prodid
@automated
Scenario:  Place an order (using Product id) with valid Shipping, Payment details and verify order number in Order Confirmation page - Checkout without profile
Given I am on product detail page for product "14700"
	And I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total on "address" page
When I enter shipping details
When I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
When I enter credit card details
	And I enter billing address


# @co_create_profile
# @automated
# Scenario:  Create a profile while Guest Checkout User flow
# Given I am on product detail page for product "14700"
# #When I retrieve product price for item 1
	# And I add item 1 to bag
# Then I see text "1 item added to your bag" 
# Then I click on checkout button
# And I click continuecheckout
# When I choose checkout without profile
# Then I am on the "shipping address" page
	# And I verify merchandise total on "address" page
# When I enter shipping details
# When I continue checkout again
# Then I am on the "Choose Shipping Options" page
	# And I verify merchandise total
# When I continue checkout again
# Then I am on the "enter payment information" page
	# And I verify merchandise total on "address" page
# When I enter credit card details
	# And I enter billing address
	# #And I create profile during guest checkout
# 	

# @co_bread_crumbs
# @automated
# Scenario: Verify Page bread crumbs / Progress indicator
# Given I am on product detail page for product "14700"
# Then I see breadcrumbs on "PDP" page
	# |first                   |second         |
	# |Dining & Entertaining   | Fine China    |
# When I add item 2 to bag
# Then I see text "1 item added to your bag" 
# Then I click on checkout button
# And I click continuecheckout
# When I choose checkout without profile
# Then I am on the "shipping address" page
	# And I see breadcrumbs on "shipping" page
	# |first                   |second         |
	# |current   | 1    |
# When I enter shipping details
# When I continue checkout again
# Then I am on the "Choose Shipping Options" page
	# And I verify merchandise total
# When I continue checkout again
# Then I am on the "payment" page
	# And I see breadcrumbs on "payment" page
	# |first                   |second         |
	# |current   | 2    |
# When I enter credit card details
	# And I enter billing address
	# And I continue checkout again
	# Then I am on the "review" page
	# And I see breadcrumbs on "review" page
	# |first                   |second         |
	# |present   | 3    |


@mani
@co_xbag
@automated
Scenario: Verify Mini bag should be displayed in all the Checkout pages till Order review
Given I am on product detail page for product "14700"
When I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I see minibag displayed
When I enter shipping details
	And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I see minibag displayed
	And I continue checkout again
	Then I am on the "payment" page
When I enter credit card details
	And I enter billing address
	And I continue checkout again
	Then I am on the "review" page
	And I see minibag displayed



@co_bagid
@automated
Scenario: Verify Mini bag should be displayed in all the Checkout pages till Order review
Given I am on product detail page for product "14700"
When I add item 1 to bag
Then I see text "1 item added to your bag" 
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I see bag_id displayed
When I enter shipping details
	And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I see bag_id displayed
	And I continue checkout again
	Then I am on the "payment" page
	And I see bag_id displayed
When I enter credit card details
	And I enter billing address
	And I continue checkout again
	Then I am on the "review" page
	And I see bag_id displayed


@demo
@co_secure
@automated
Scenario: Verify checkout pages should be secure
Given I am on product detail page for product "14700"
When I add item 1 to bag
Then I see text "1 item added to your bag" 
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I see the page is secure
When I enter shipping details
	And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I see the page is secure
	And I continue checkout again
	Then I am on the "payment" page
	And I see the page is secure
When I enter credit card details
	And I enter billing address
	And I continue checkout again
	Then I am on the "review" page
	And I see the page is secure


@demo
@co_review_fields
@automated
Scenario: Verify checkout pages should be secure
Given I am on product detail page for product "14700"
When I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
When I enter shipping details
	And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I continue checkout again
Then I am on the "payment" page
When I enter credit card details
	And I enter billing address
	And I continue checkout again
Then I am on the "review" page
	And I validate the fields_and_buttons on "review" page


# @co_promo
# @automated
# Scenario: Verify Promo code field is displayed in Mini bag page
# Given I am on product detail page for product "14700"
# When I add item 1 to bag
# Then I click on checkout button
# And I enter promocode
# When I click continuecheckout
# When I choose checkout without profile
# # When I checkout without profile
# #Then I am on the "shipping address" page
	# And I see promo_code displayed

@co_pagetitle
@automated
Scenario: Verify checkout pages should be secure
Given I am on product detail page for product "14700"
When I add item 1 to bag
Then I see text "1 item added to your bag"
	Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
	And I validate pagetitle on "Shipping" page for "checkout"
When I enter shipping details
	And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I continue checkout again
	Then I am on the "payment" page
	And I validate pagetitle on "Billing" page for "checkout"
When I enter credit card details
	And I enter billing address
	And I continue checkout again
	Then I am on the "review" page
	And I validate pagetitle on "Review" page for "checkout"


@co_address
@automated
Scenario: Verify 'billing address same as shipping address' functionality on payment page.
Given I am on product detail page for product "14700"
When I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I validate pagetitle on "Shipping" page for "checkout"
When I enter shipping details
	And I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I continue checkout again
	Then I am on the "payment" page
	And I validate pagetitle on "Billing" page for "checkout"
When I enter credit card details
	And I enter billing address
Then I validate billing address same as shipping address



@co_shipping_back
@automated
Scenario: Verify back one step from shipping page
Given I am on product detail page for product "14700"
When I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I validate pagetitle on "Shipping" page for "checkout"
When I go back one step
Then I see text "your shopping bag"


@co_billing_back
@automated
Scenario: Verify back one step from payment page
Given I am on product detail page for product "14700"
When I add item 1 to bag
#Then I see text "1 item added to your bag"
Then I click on checkout button
And I click continuecheckout
When I choose checkout without profile
Then I validate pagetitle on "Shipping" page for "checkout"
When I enter shipping details
	And I continue checkout again
	And I continue checkout again
Then I am on the "payment" page
	And I validate pagetitle on "Billing" page for "checkout"
When I go back one step
Then I am on the "Choose Shipping Options" page


@co_edit_shipping
@automated
Scenario:  Click change shipping info button in order review page, update the details in shipping page and continue checkout.
#Given I am on order review page
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#When I select the subcategory "random"
When I select any item from collection
	And I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
When I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
When I enter shipping details
When I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
When I enter credit card details
	And I enter billing address
	And I continue checkout again
Then I am on the "review" page
When I edit shipping address
Then I am on the "shipping address" page
And I enter new shipping address
When I continue checkout again
Then I am on the "review" page
And shipping address should be updated in order review page


@co_edit_payment
@automated
Scenario:  Click change payment info button in order review page, update the details in payment page and continue checkout.
#Given I am on order review page
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#When I select the subcategory "random"
When I select any item from collection
	And I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
When I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
When I enter shipping details
When I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
When I enter credit card details
	And I enter billing address
	And I continue checkout again
Then I am on the "review" page
When I edit payment address
Then I am on the "enter payment information" page
And I enter sec code "123"
And I enter new payment information
When I continue checkout again
Then I am on the "review" page
And I see updated payment information


@co_address_order
@automated
Scenario:  Verify Shipping details and Billing details on Order review page
#Given I am on order review page
Given I am on the Macy's home page
	And I select "random" from the navigation menu
When I select the category "random"
Then I should see the current category
#When I select the subcategory "random"
When I select any item from collection
	And I add item 1 to bag
Then I see text "1 item added to your bag"
Then I click on checkout button
When I click continuecheckout
When I choose checkout without profile
Then I am on the "shipping address" page
	And I verify merchandise total
When I enter shipping details
When I continue checkout again
Then I am on the "Choose Shipping Options" page
	And I verify merchandise total
When I continue checkout again
Then I am on the "enter payment information" page
	And I verify merchandise total
When I enter credit card details
	And I enter billing address
	And I continue checkout again
Then I am on the "review" page
	And the billing address should be correct on order review page
	Then the shipping address should be correct on order review page