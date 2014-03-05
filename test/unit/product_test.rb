require 'test_helper'
class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    product.price = -1
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test "product is not valid without a unique title - il8n" do
    product = Product.new(title:  products(:iphone).title,
                          description: "yyy",
                          price: 1,
                          image_url:  "fred.gif")
    assert product.save
    assert_equal Il8n.translate('activerecord.errors.messages.taken'), product.errors[:title].join('; ')
  end

end
