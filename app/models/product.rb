class Product < ActiveRecord::Base
    validates :title, :description, :image_url, presence: true
    validates :price, format: { :with => /\A\d+(?:\.\d{0,2})?\z/, message: I18n.t('two decimals please')}, numericality: {greater_than_or_equal_to: 0.01} 
    validates :title, uniqueness:true
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\Z}i,
        message: I18n.t('must be a URL for GIF, JPG or PNG image.')
}
end
