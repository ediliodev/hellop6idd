class Trabat < ApplicationRecord
	validates_presence_of :nombre # no puede crearse una traba en blanco ok.
	validates :nombre, :uniqueness => {:case_sensitive => false}

end
