require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My Book Title", description: "yyy")
    product.image.attach(io: File.open("test/fixtures/files/peas.jpg"),
                         filename: "peas.jpg",
                         content_type: "image/jpeg")

    product.price = -1
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    product = Product.new(title: "My Book Title",
                          description: "yyy",
                          price: 1)
    product.image.attach(io: File.open("test/fixtures/files/peas.jpg"),
                         filename: "peas.jpg",
                         content_type: "image/jpeg")
    assert product.valid?, "image/jpeg must be valid"

    product.image.attach(io: File.open("test/fixtures/files/logo.svg"),
                         filename: "logo.svg",
                         content_type: "image/svg+xml")
    assert_not product.valid?, "image/svg+xml must be invalid"
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:peas).title,
                          description: "yyy",
                          price: 1)
    product.image.attach(io: File.open("test/fixtures/files/peas.jpg"),
                         filename: "peas.jpg",
                         content_type: "image/jpeg")
    assert product.invalid?
    assert_equal [ I18n.translate("errors.messages.taken") ], product.errors[:title]
  end
end
