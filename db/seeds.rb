# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Script para llenado de Manageuserbt con 2,000 usuarios para fines de requisitos de disenio solamente ok. ted.

#2000.times do |i|
#	clean_user = Manageuserbt.new
#	clean_user.email = "usergeneric#{i}@central.com"
#	clean_user.password = "******"
#	clean_user.save
#end



#Script para llenado de disponibilidad inicial de las Quinielas del sorteo Nacional Noche.

#100.times do |number|
#	entrada = Controlqnnt.new
#	entrada.numero = number
#	entrada.limite = 1000
#	entrada.vendida = 0
#	entrada.save
#end


# # El de abajo completo ok 100 numeros en 6 sorteos adicionales quinielas ok. ted. 

#["controlqgmt", "controlqleit", "controlqreat", "controlqnytt", "controlqnynt", "controlqltkt" ].each do |modelo|
	
#	 modelo = modelo.capitalize.classify.constantize

#	100.times do |number|
#		entrada = modelo.new
#		entrada.numero = number
#		entrada.limite = 1000
#		entrada.vendida = 0
#		entrada.save
# 	end
# end






 #A - TODOS LOS MODELOS DE QUINIELA JUNTOS:

#["controlqnnt", "controlqgmt", "controlqleit", "controlqreat", "controlqnytt", "controlqnynt", "controlqltkt" ].each do |modelo|
#
#	 modelo = modelo.capitalize.classify.constantize
#
#	100.times do |number|
#		entrada = modelo.new
#		entrada.numero = number
#		entrada.limite = 1000
#		entrada.vendida = 0
#		entrada.save
#	end
# end



#-------------------------------------------------------------------------------------------


#Script para llenado de disponibilidad inicial de los Pale del sorteo Nacional Noche.


##100.times do |n1|
##
##	n1_sigla = (n1.to_i < 10 )? ("0" + n1.to_s) : n1.to_s
##
##	n1.upto(99) do |n2|
##		n2_sigla = (n2.to_i < 10 )? ("0" + n2.to_s) : n2.to_s
##
##		#procesar insercion de combinacione y disponibiliad de pales:
##		pale = Controlpnnt.new
##		pale.n1 = n1
##		pale.n2 = n2
##		pale.siglas = n1_sigla + "-" + n2_sigla
##		pale.limite = 100
##		pale.vendida = 0
##		pale.save
##
##	end
##
## end
# Fin de llenado de Pale.



#llenado hasta el 05-99 (6 veces del 0 al 5 pra pruba solamente. ok. ted.)

#["controlpgmt", "controlpleit", "controlpreat", "controlpnytt", "controlpnynt", "controlpltkt" ].each do |modelo|
#	
#		 modelo = modelo.capitalize.classify.constantize
#
#		 6.times do |n1|
#
#			n1_sigla = (n1.to_i < 10 )? ("0" + n1.to_s) : n1.to_s
#
#			n1.upto(99) do |n2|
#				n2_sigla = (n2.to_i < 10 )? ("0" + n2.to_s) : n2.to_s
#
#				#procesar insercion de combinacione y disponibiliad de pales:
#				pale = modelo.new
#				pale.n1 = n1
#				pale.n2 = n2
#				pale.siglas = n1_sigla + "-" + n2_sigla
#				pale.limite = 100
#				pale.vendida = 0
#				pale.save
#
#			end
#
#		 end
#end





# B - TODOS LOS MODELOS DE PALE JUNTOS:


#[ "controlpnnt", "controlpgmt", "controlpleit", "controlpreat", "controlpnytt", "controlpnynt", "controlpltkt" ].each do |modelo|
#	
#		 modelo = modelo.capitalize.classify.constantize
#
#		 100.times do |n1|
#
#			n1_sigla = (n1.to_i < 10 )? ("0" + n1.to_s) : n1.to_s
#
#			n1.upto(99) do |n2|
#				n2_sigla = (n2.to_i < 10 )? ("0" + n2.to_s) : n2.to_s
#
#				#procesar insercion de combinacione y disponibiliad de pales:
#				pale = modelo.new
#				pale.n1 = n1
#				pale.n2 = n2
#				pale.siglas = n1_sigla + "-" + n2_sigla
#				pale.limite = 100
#				pale.vendida = 0
#				pale.save
#
#			end
#
#		 end
#end













#-------------------------------------------------------------------------------------------

#Script para llenado de disponibilidad inicial de Tripletas del sorteo Nacional Noche.


#100.times do |n1|
#
#	n1_sigla = (n1.to_i < 10 )? ("0" + n1.to_s) : n1.to_s
#
#	n1.upto(99) do |n2|
#		n2_sigla = (n2.to_i < 10 )? ("0" + n2.to_s) : n2.to_s
#
#
#		n2.upto(99) do |n3|
#		    n3_sigla = (n3.to_i < 10 )? ("0" + n3.to_s) : n3.to_s
#			#procesar insercion de combinacione y disponibiliad de tripletas:
#			tripleta = Controltnnt.new
#			tripleta.n1 = n1
#			tripleta.n2 = n2
#			tripleta.n3 = n3
#			tripleta.siglas = n1_sigla + "-" + n2_sigla + "-" + n3_sigla
#			tripleta.limite = 10
#			tripleta.vendida = 0
#	    	tripleta.save
#
#   	end
#
#	end
#
#
#
#end

# Fin de llenado de Tripletas.


#Aqui llenaremos las tablas de tripletas hasta el 01-99-99 para fines de prueba. ok ted. seed.

#["controltnnt", "controltgmt", "controltleit", "controltreat", "controltnytt", "controltnynt", "controltltkt" ].each do |modelo|
#	
#		modelo = modelo.capitalize.classify.constantize
#
#
#		100.times do |n1|
#
#			n1_sigla = (n1.to_i < 10 )? ("0" + n1.to_s) : n1.to_s
#
#			n1.upto(99) do |n2|
#				n2_sigla = (n2.to_i < 10 )? ("0" + n2.to_s) : n2.to_s
#
#
#				n2.upto(99) do |n3|
#				    n3_sigla = (n3.to_i < 10 )? ("0" + n3.to_s) : n3.to_s
#					#procesar insercion de combinacione y disponibiliad de tripletas:
#					tripleta = modelo.new
#					tripleta.n1 = n1
#					tripleta.n2 = n2
#					tripleta.n3 = n3
#					tripleta.siglas = n1_sigla + "-" + n2_sigla + "-" + n3_sigla
#					tripleta.limite = 5
#					tripleta.vendida = 0
#			    	tripleta.save
#
#		  	end
#
#			end
#
#		end
#
#	end # end del each del aaray.


#-------------------------------------------------------------------------------------------





# C - TODOS LOS MODELOS DE TRIPLETA JUNTOS:



# ["controltgmt", "controltleit", "controltreat", "controltnytt", "controltnynt", "controltltkt" ].each do |modelo|
# 	
# 		modelo = modelo.capitalize.classify.constantize
# 
# 
# 		2.times do |n1|
# 
# 			n1_sigla = (n1.to_i < 10 )? ("0" + n1.to_s) : n1.to_s
# 
# 			n1.upto(99) do |n2|
# 				n2_sigla = (n2.to_i < 10 )? ("0" + n2.to_s) : n2.to_s
# 
# 
# 				n2.upto(99) do |n3|
# 				    n3_sigla = (n3.to_i < 10 )? ("0" + n3.to_s) : n3.to_s
# 					#procesar insercion de combinacione y disponibiliad de tripletas:
# 					tripleta = modelo.new
# 					tripleta.n1 = n1
# 					tripleta.n2 = n2
# 					tripleta.n3 = n3
# 					tripleta.siglas = n1_sigla + "-" + n2_sigla + "-" + n3_sigla
# 					tripleta.limite = 5
# 					tripleta.vendida = 0
# 			    	tripleta.save
# 
# 		  	end
# 
# 			end
# 
# 		end
# 
# 	end # end del each del aaray.






#-------------------------------------------------------------------------------------------




# D - SCRIPT PARA LLENADO DISPONIBILIDAD DE TODOS LOS SUPERPALES JUNTOS: SP LEIDSA/REAL/LOTEKA - NACIONAL:

#controlspleinnt
#controlspreannt
#controlspltknnt

[ "controlspleinnt", "controlspreannt", "controlspltknnt" ].each do |modelo|
	
		 modelo = modelo.capitalize.classify.constantize

		 100.times do |n1|

			n1_sigla = (n1.to_i < 10 )? ("0" + n1.to_s) : n1.to_s

			n1.upto(99) do |n2|
				n2_sigla = (n2.to_i < 10 )? ("0" + n2.to_s) : n2.to_s

				#procesar insercion de combinacione y disponibiliad de superpales (en este caso dejaremos la variable de abajo como pale, pero sabemos que estamos populando los modelos de super pales ok ted.):
				pale = modelo.new
				pale.n1 = n1
				pale.n2 = n2
				pale.siglas = n1_sigla + "-" + n2_sigla
				pale.limite = 100
				pale.vendida = 0
				pale.save

			end

		 end
end

