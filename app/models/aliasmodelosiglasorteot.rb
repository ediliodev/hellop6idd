class Aliasmodelosiglasorteot < ApplicationRecord
	validates :siglasorteo, uniqueness: true
end
