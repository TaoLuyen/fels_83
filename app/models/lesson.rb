class Lesson < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  has_many :answers, through: :results
  accepts_nested_attributes_for :results
  scope :start_by, ->user_id{where user_id: user_id}
  before_create :create_words

  def base_resource
    "\##{self.id},#{lesson_path self}|#{self.category.base_resource}"
  end

  private
  def create_words
    self.words = self.category.words.order("RANDOM()").limit 20
  end
end
