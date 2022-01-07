class Controldepagogt < ApplicationRecord
	
	validates :tipojugada, :limitexticket, :limiteglobal, presence: { message: "No puede estar en Blanco. Favor completar." }
	
	validates :limitexticket, :limiteglobal, numericality: { only_integer: true }

end
