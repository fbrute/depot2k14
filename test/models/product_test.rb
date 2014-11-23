require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(title:        "My Book Title",
                          description:  "yyy",
                          image_url:    "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["doit être supèrieur ou égal à 0.01"], product.errors[:price]

    #assert_equal ": deux chiffres après la virgule s'il vous plaît", product.errors[:price][1]

    product.price = 0 
    assert product.invalid?
    assert_equal ["doit être supèrieur ou égal à 0.01"], product.errors[:price]

    #assert_equal ": deux chiffres après la virgule s'il vous plaît", product.errors[:price][1]


    product.price = 1.00 
    assert product.valid?
    #assert_equal ": deux chiffres après la virgule s'il vous plaît", product.errors[:price]

  end
  
  def new_product(image_url)
    Product.new(title:        "My book Title",
                description:  "yyy",
                price:        1,
                image_url:  image_url)
  end
  
  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
              http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.git.more }

   ok.each do |name|
     assert new_product(name).valid? "#{name} should be valid"
   end

   bad.each do |name|
     assert new_product(name).invalid? "#{name} shouldn't be valid"
   end
 
  end

  test "product is not valid without a unique title" do
    product = Product.new(title:        products(:ruby).title,
                          description:  "yyy",
                          price:        1,
                          image_url:  "fred.gif")
  assert product.invalid?
  assert_equal [I18n.t('errors.messages.taken')], product.errors[:title]
  end

end
