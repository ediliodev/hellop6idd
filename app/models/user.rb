class User < ApplicationRecord
	has_many :tickets
	belongs_to :gppt
	belongs_to :supervisort
	 #belongs_to :consorciot
#	belongs_to :tipousuariot
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 
 # devise :database_authenticatable, :registerable,
 # :recoverable, :rememberable, :trackable, :validatable

   devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable

  

  # validates_presence_of :nombre, :apellidos, :tipousuariot_id, :sucursalt_id, :on => :create, :message => "Can't be blank (Campo Obligatorio)"
end

#LOS MUDULOS QUE ACTIVE AQUI TENGO DE DESCOMENTAR O VICEVERSA EN LA MIGRACIONDE DEL MISMO.

