class Lineat < ApplicationRecord
	#validacion de algunos atributos necesarios ok: 
	validates :coliseo, :bloque, :pelea, :azul, :blanco, :mla, :mlb, :tiempoml, :oua, :oub, presence: { message: "No puede estar en Blanco. Favor completar." }
	
    #validar valores numericos para atributos bloque y pelea, aunque se guarden como string ok:
    validates :bloque, :pelea, numericality: { only_integer: true }

	#Que no se repitan las peleas por dia: Sacado de este link: https://stackoverflow.com/questions/1499388/rails-validates-uniqueness-of-scoped-by-date
	validates_uniqueness_of :pelea, conditions: -> { where("DATE(created_at) = ?", Date.today) }, message: "Ya asignada, Favor elegir nuevo numero de pelea" 

	#validar el Money Line format:
	validates :mla, :mlb, :oua, :oub, format: { with:  /\A[+-]\d{3}\z/,
    message: "Formato de linea invalido. Ej. -120, +100, ok."}
    #nota futura para lina como esta +80, solo poner +080 y la validacion pasa ok ted. FYI only ok.
    # sacado de link: https://guides.rubyonrails.org/active_record_validations.html

    #validacion de formato del tiempo:
    validates :tiempoml, format: { with:  /\A\d\d\.\d\d\z/,
    message: "Formato invalido. Ej. 04.00, 03.30, 02.45, ok"}
    

    #solo para el timepo de resultado fina, que puede ser blanco al principio, luego en el controlador de resultados validamos que no este en blaco manualmente ok.Aqui  para que nos filtre el formato de hora de entrada ok. ted.
    validates :tiempofinalizado, format: { with:  /\A\d\d\.\d\d\z/,
    message: "Formato invalido. Ej. 04.00, 03.30, 02.45, ok"}, allow_blank: true
    


end
