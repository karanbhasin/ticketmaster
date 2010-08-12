class Ticket < ActiveRecord::Base
  belongs_to :project
  has_many :ticket_histories
  validates_presence_of :description
end
