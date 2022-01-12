class Ability
  include CanCan::Ability

  def initialize(user)
    
       user ||= User.new # guest user (not logged in)

       if  user.tipousuariot_id == 2
       #   if User.last.tipousuariot.tipo_usuario == "venta"

        can :manage, :all 
       # cannot [:create,:update,:destroy], [Loteriat, Sorteot, Menut, Ticketsganadorest,Controlpnnt,Controlqnnt,Controltnnt  ,Controlspnnt ,Controlqgmt  ,Controlpgmt  ,Controltgmt  ,Controlqleit ,Controlpleit ,Controltleit ,Controlqreat ,Controlpreat ,Controltreat ,Controlqnytt ,Controlpnytt ,Controltnytt ,Controlqnynt ,Controlpnynt ,Controltnynt ,Controlqltkt ,Controlpltkt ,Controltltkt ]
        cannot [:update,:destroy], [Menuposrventadiaactualt, Menuposrventaxfechat, Menuadmrresultadoglobalt, Menuadmrresultadoglobalxsupervisort, Menuf10t]
        #No aparecieron estos modelos arriba: Menupostanularticket, Menupostconsultarticket, Menupostpagarticket,Menuposccuadrediaactualt,Menuposccuadreotrodiat
        #Eliminado manual mientras tanto: Menuposrventadiaactualt menuposrventaxfechat
        can :update, [Controlqnnt, Controlpnnt, Controltnnt, Controlspnnt ,Controlqgmt  ,Controlpgmt  ,Controltgmt  ,Controlqleit ,Controlpleit ,Controltleit ,Controlqreat ,Controlpreat ,Controltreat ,Controlqnytt ,Controlpnytt ,Controltnytt ,Controlqnynt ,Controlpnynt ,Controltnynt ,Controlqltkt ,Controlpltkt ,Controltltkt]
       # can :manage, :all # Exepto las combinaciones de QPT y Editar Borrar ?[Y las Loterias y Sorteos klk solo Webmaster mete mano ahi... OJo definifr algo bien aki.] o Crear numeros de ahi... klk
       # can [:create, :read, :update], [Jugadalot, Menut]
       cannot [:destroy], [Activacionclientet]
       can :update, [Sorteot]
       cannot [:destroy], [User]


       end
       
       if user.tipousuariot_id == 3
        #can :manage, :all

          can :read, Continentet
          can :read, Paist
          can :read, Monedat
          can :read, Loteriat
          can :read, Sorteot
          can :read, Consorciot
          can :read, Gppt
          can :read, Ciudadt
          can :read, Provinciat
          can :read, Zonat
          can :read, Sociot
          can :read, Supervisort
          can :read, Colectort
          can :read, Mensajepiedepaginat
          can :read, Horariosorteot
          can :read, User, id: user.id #Luego especificar User :id => current_user.id por ejemplo ok ted. Que pueda leer solo ese usuario(id) ver en link cancancan ted internet. ok.
          can :read, Ganadorest
          can :read, Aliasmodelosiglasorteot
          can :read, Menut
          can [:create,:read,:update], [:Ticket]
          can [:create,:read], [:Impresiont]
          can :manage, Recordqnnt
          can :manage, Jugadalot
          can :manage, Recordpnnt 
          can :manage, Recordtnnt
          can :manage, Recordspnnt  
          can :manage, Menuposrventadiaactualt  
          can :manage, Menuposrventaxfechat
          #can :manage, Menupostanularticket 
          #can :manage, Menupostconsultarticket  
          #can :manage, Menupostpagarticket  
          #can :manage, Menuposccuadrediaactualt 
          #can :manage, Menuposccuadreotrodiat 
          can :manage, Menuadmrresultadoglobalt 
          can :manage, Menuadmrresultadoglobalxsupervisort  
          can :manage, Menuf10t
          can :manage, Recordqgmt 
          can :manage, Recordpgmt 
          can :manage, Recordtgmt 
          can :manage, Recordqleit
          can :manage, Recordpleit
          can :manage, Recordtleit
          can :manage, Recordqreat
          can :manage, Recordpreat
          can :manage, Recordtreat
          can :manage, Recordqnytt
          can :manage, Recordpnytt
          can :manage, Recordtnytt
          can :manage, Recordqnynt
          can :manage, Recordpnynt
          can :manage, Recordtnynt
          can :manage, Recordqltkt
          can :manage, Recordpltkt
          can :manage, Recordtltkt
          can [:read,:update], Ticketsganadorest
          can [:read,:update], Controlpnnt
          can [:read,:update], Controlqnnt
          can [:read,:update], Controltnnt  
          can [:read,:update], Controlspnnt 
          can [:read,:update], Controlqgmt  
          can [:read,:update], Controlpgmt  
          can [:read,:update], Controltgmt  
          can [:read,:update], Controlqleit 
          can [:read,:update], Controlpleit 
          can [:read,:update], Controltleit 
          can [:read,:update], Controlqreat 
          can [:read,:update], Controlpreat 
          can [:read,:update], Controltreat 
          can [:read,:update], Controlqnytt 
          can [:read,:update], Controlpnytt 
          can [:read,:update], Controltnytt 
          can [:read,:update], Controlqnynt 
          can [:read,:update], Controlpnynt 
          can [:read,:update], Controltnynt 
          can [:read,:update], Controlqltkt 
          can [:read,:update], Controlpltkt 
          can [:read,:update], Controltltkt
          can :manage, Lineatprint
          can :manage, Menut

       end # end del (if user.tipousuariot_id == 3)
    

       if  (user.tipousuariot_id != 2) && (user.tipousuariot_id != 3)
         cannot :manage, :all # Si no es admin ni ventas que no acceda a ingun recurso. Seguridad extrema ted.
       end

  


#ideas: 
# if (si es admin can :manange, :all)
# if (si es ventas can :manange, Ventas, jugadadlots,reportes? algunos read(reportes) y otros create(jugadalots) ? :all)
# Si no es admin ni ventas. No puede procesar peticiones. Cancancan execption?
#probar klk.

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

  end # end de la funcion initialize.

end # fin de la clase.



#CRUD
# cannot [:create,:update,:destroy], [Loteriat, Sorteo, Menut, Menuposrventadiaactualt, Menuposrventaxfechat, Menupostanularticket, Menupostconsultarticket, Menupostpagarticket, Menuposccuadrediaactualt, Menuposccuadreotrodiat, Menuadmrresultadoglobalt, Menuadmrresultadoglobalxsupervisort, Menuf10t, Ticketsganadorest,Controlpnnt,Controlqnnt,Controltnnt  ,Controlspnnt ,Controlqgmt  ,Controlpgmt  ,Controltgmt  ,Controlqleit ,Controlpleit ,Controltleit ,Controlqreat ,Controlpreat ,Controltreat ,Controlqnytt ,Controlpnytt ,Controltnytt ,Controlqnynt ,Controlpnynt ,Controltnynt ,Controlqltkt ,Controlpltkt ,Controltltkt ]


#Menuposrventadiaactualt, Menuposrventaxfechat, Menupostanularticket, Menupostconsultarticket, Menupostpagarticket, Menuposccuadrediaactualt, Menuposccuadreotrodiat, Menuadmrresultadoglobalt, Menuadmrresultadoglobalxsupervisort, Menuf10t, 

#Ticketsganadorest,Controlpnnt,Controlqnnt,Controltnnt  ,Controlspnnt ,Controlqgmt  ,Controlpgmt  ,Controltgmt  ,Controlqleit ,Controlpleit ,Controltleit ,Controlqreat ,Controlpreat ,Controltreat ,Controlqnytt ,Controlpnytt ,Controltnytt ,Controlqnynt ,Controlpnynt ,Controltnynt ,Controlqltkt ,Controlpltkt ,Controltltkt



