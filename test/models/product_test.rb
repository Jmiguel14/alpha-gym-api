require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should get product" do
    product = products(:protein)
    assert product.valid?
  end

  test "should validate presence of attributes" do
    product = Product.new(
      name: "Protein",
      description: "Protein is a macronutrient that is essential for building and repairing tissues.",
    )
    assert_not product.valid?
    assert_equal product.errors.full_messages, ["Purchase price can't be blank", "Sale price can't be blank", "Sku can't be blank", "Quantity can't be blank", "Purchase price is not a number", "Sale price is not a number", "Quantity is not a number"]
  end

  test "should validate numericality of attributes" do
    product = Product.new(
      name: "Protein",
      description: "Protein is a macronutrient that is essential for building and repairing tissues.",
      purchase_price: 10.00,
      sale_price: 15.00,
      sku: "PROTEIN123",
      quantity: 100
    )
    assert product.valid?
    product.purchase_price = -10.00
    assert_not product.valid?
    assert_equal product.errors.full_messages, ["Purchase price must be greater than 0"]
    product.purchase_price = 0.00
    assert_not product.valid?
    assert_equal product.errors.full_messages, ["Purchase price must be greater than 0"]
    product.purchase_price = 10.00
    assert product.valid?
    product.sale_price = -15.00
    assert_not product.valid?
    assert_equal product.errors.full_messages, ["Sale price must be greater than 0"]
    product.sale_price = 0.00
    assert_not product.valid?
    assert_equal product.errors.full_messages, ["Sale price must be greater than 0"]
    product.sale_price = 15.00
    assert product.valid?
    product.quantity = -100
    assert_not product.valid?
    assert_equal product.errors.full_messages, ["Quantity must be greater than or equal to 0"]
    product.quantity = 0
    assert product.valid?
    product.quantity = 100
    assert product.valid?
  end

  test "should update quantity of product" do
    product = products(:protein)
    product.quantity = 95
    product.save
    assert_equal product.quantity, 95
  end

  test "should not update quantity of product if it is negative" do
    product = products(:protein)
    product.quantity = -100
    assert_not product.valid?
    assert_equal product.errors.full_messages, ["Quantity must be greater than or equal to 0"]
  end
  
end
