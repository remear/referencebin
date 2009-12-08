# == Schema Information
#
# Table name: flags
#
#  id          :integer(4)      not null, primary key
#  bookmark_id :integer(4)      not null
#  reason      :string(255)     not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Flag < ActiveRecord::Base
  belongs_to :flaggable, :polymorphic => true
end
