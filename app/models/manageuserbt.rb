class Manageuserbt < ApplicationRecord
	validates_presence_of :password, :on => :create, :message => "can't be blank"
end
