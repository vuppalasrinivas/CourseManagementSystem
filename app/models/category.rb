class Category < ApplicationRecord
  has_many :sub_categories, :class_name => "Category", :foreign_key => "parent_id"
  belongs_to :parent_category, :class_name => "Category", :optional => true
  validate :validate_parent
  has_many :courses
  validates :name, presence: true

  def validate_parent
    if self.id && self.id == self.parent_id
      errors.add(:base, "Invalid Parent Category")
    end
  end

  def to_s
    name
  end

  def parent_category_name
    if self.parent_id
      Category.where(id: self.parent_id).first
    end
  end

  def self.get_subcategory_ids(id)
    parent_category = Category.find(id)
    if parent_category
      unless parent_category.sub_categories.empty?
        sub_categories_ids = parent_category.sub_categories.pluck(:id)
      else
        sub_categories_ids = [parent_category.id]
      end
    end
  end
end
