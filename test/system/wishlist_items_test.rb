require "application_system_test_case"

class WishlistItemsTest < ApplicationSystemTestCase
  setup do
    @wishlist_item = wishlist_items(:one)
  end

  test "visiting the index" do
    visit wishlist_items_url
    assert_selector "h1", text: "Wishlist Items"
  end

  test "creating a Wishlist item" do
    visit wishlist_items_url
    click_on "New Wishlist Item"

    fill_in "Item", with: @wishlist_item.item_id
    fill_in "User", with: @wishlist_item.user_id
    click_on "Create Wishlist item"

    assert_text "Wishlist item was successfully created"
    click_on "Back"
  end

  test "updating a Wishlist item" do
    visit wishlist_items_url
    click_on "Edit", match: :first

    fill_in "Item", with: @wishlist_item.item_id
    fill_in "User", with: @wishlist_item.user_id
    click_on "Update Wishlist item"

    assert_text "Wishlist item was successfully updated"
    click_on "Back"
  end

  test "destroying a Wishlist item" do
    visit wishlist_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wishlist item was successfully destroyed"
  end
end
