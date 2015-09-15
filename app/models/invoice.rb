class Invoice < ActiveRecord::Base
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items


  def self.successful
    joins(:transactions).where("result = 'success'")
  end

end
