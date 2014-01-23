#encoding: utf-8
module RegistrationsHelper
  def gender_options
    {'male' => _('hombre'), 'female' => _('mujer')}.map {|k,v| [v,k]} 
  end

  def seeking_options
    [[_('hombre buscando una mujer'), 'man seeking woman' ], [_('mujer buscando un hombre'), 'woman seeking man' ], [_('hombre buscando un hombre'), 'man seeking man' ], [_('mujer buscando una mujer'), 'woman seeking woman']]
  end

  def marital_status_options
    [[_('solter@'),'single'],[_('ocupad@'), 'engaged'], [_('separad@'), 'separated'], [_('divorciad@'), 'divorced'], [_('casad@'), 'married'], [_('viud@'), 'widowed']]
  end

  def country_options
    ["España"]
  end

  def child_options
    [[_('tengo hijos'), 'have-children'], [_('no tengo hijos'), 'no-children'], [_('no tengo hijos, y no quiero tener'), 'no-want-children'], [_('no tengo hijos, pero quiero tener'), 'no-kids-i-want'], [_('si tengo hijos, y no quiero tener mas '), 'have-children-no-want-more'], [_('si tengo hijos, y quiero tener mas '), 'have-children-want-more'], [_('no me gustan los niños'), 'no-like-kids']]
  end

  def house_options
    [[_('sol@'), 'alone'], [_('en pareja'), 'couple'], [_('con mis hijos'), 'with-kids'], [_('ocasionalmente con mis hijos'), 'occasionally-with-children'], [_('acompañad@'), 'accompanied'], [_('con mis padres'), 'with-parents']]
  end

  def physical_desc_options
    [[_('normal'),'normal'], [_('atractiv@'), 'sexy'], [_('guap@'), 'pretty'], [_('del montón'), 'of-the-mill']]
  end

  def physical_style_options
    [[_('bohemio'), 'bohemian'], [_('clásico'), 'classic'],[_('indie/casual'), 'indie/casual'], [_('deportivo'),'sport'], [_('formal'), 'formal'], [_('a la moda'), 'trendy'], [_('rockero'), 'rocker'], [_('pijo'), 'preppy']]    
  end

  def eyes_options
    [[_('marrón'), 'brown'],[_('negro'), 'black'], [_('verde'), 'green'],[_('gris'), 'gray'],[_('café'), 'coffee'],[_('azul'), 'blue']]
  end

  def hair_options
    [[_('rubio'), 'blond'], [_('pelirrojo'), 'redhead'],[_('gris'), 'gray' ],[_('marrón'), 'brown'],[_('negro'),'black']]
  end

  def hair_style_options
    [[_('corto'), 'short'],[_('muy corto'),'very short'],[_('largo'), 'large'],[_('afeitado'), 'shaved' ], [_('sin pelo'), 'hairless']]
  end

  def complexion_options
    {'thin' => _('delgado'), 'normal' => _('normal'), 'nice' => _('muy bien'), 'athletic' => _('atlético'), 'strong' => _('fuerte'),  'curvy' => _('con curvas'), 'obese' => _('obeso')}.map {|k,v| [v,k]}
  end

  def smoke_options
    {'smoker' => _('Fumo'), 'non-smoker' => _('No fumo'), 'smoker-hater' => _('Soy antitabaco'),'not-mind-smoke' => _('No me molesta el humo'), 'smoke-leave-couple' => _('Fumo pero lo dejaría por mi pareja'), 'social-smoker' => _('Soy fumador social')}.map {|k,v| [v,k]}
  end

  def religion_options
    {'agnostic' => _('agnóstico'), 'atheist' => _('ateo'), 'christian' => _('cristiano'), 'jewish' => _('judío'), 'catholic' => _('católico'), 'muslim' => _('musulmán'), 'hindu' => _('indú'), 'buddhist' => _('budista')}.map {|k,v| [v,k]}
  end

  def ethnicity_options
    {'hispanic' => _('hispana'), 'arab' => _('árabe'), 'indian' => _('india'), 'european' => _('europea'), 'african' => _('africana'), 'asian' => _('asiática') }.map {|k,v| [v,k]}
  end

  def language_options
    { 'english' => _('Inglés'), 'spanish' => _('Español'), 'french' => _('Francés'), 'italian' => _('Italiano'), 'other' => _('otro') }.map {|k,v| [v,k]} 
  end

  def language_level_options
    { 'low' => _('bajo'), 'medium' => _('medio'), 'hight' => _('alto') }.map {|k,v| [v,k]} 
  end

  def study_level_options
    {'school' => _('instituto o inferior'), 'high-school' => _('bachillerato'),'certified' => _('diplomado'), 'professional' => _('módulo profesional'), 'graduate' => _('licenciado o superior')}.map {|k,v| [v,k]}
  end

  def job_options
    {'artistic' => _('trabajos artísticos y creativos '),'banking' => _('banca, financiero'),'administrative' => _('adminsitrativo'), 'technology' => _('ordenadores y tecnología'),'construction' => _('construcción'),'education' => _('educación'), 'advertising' => _('publicidad, entretenimiento y medios'),'management' => _('ejecutivo y gestión '),'health'=> _('salud'), 'travel' => _('viajes'),'legal' => _('servicios legales'),'military' => _('militar'),'employee' => _('empleado'), 'public-employee' => _('empleado público / gobierno'),'science' => _('ciencia'), 'sales' => _('ventas y márketing'), 'transportation' => _('transporte y logística '),'unemployed' => _('desempleado'),'retired' => _('jubilado'), 'retired-temporarily' => _('retirado temporalmente'),'studying' => _('estoy estudiando')}.map {|k,v| [v,k]}
  end

  def diet_options
    {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'), 'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('soy muy maniátic@ con la comida'), 'like-all' => _('me gusta todo'), 'adapt' => _('me adapto fácilmente')}.map {|k,v| [v,k]}
  end

  def alcohol_options
    {'when-go-out' => _('me gusta beber solo cuando salgo'), 'not-drink' => _('no bebo alcohol'), 'occasionally' => _('bebo ocasionalmente'), 'drinker' => _('soy bebedor'), 'meke-me-sick' => _('el alcohol no me sienta bien')}.map {|k,v| [v,k]}
  end

  def wedding_opinion_options
    {'would-marry' => _('Me gustaría casarme'), 'would-not-marry' => _('No me gustaría casarme'), 'not-believe' => _('No creo en el matrimonio'), 'married-no-repeat'=> _('Ya he estado casado y no quiero repetir'), 'married-repeat' => _('Ya he estado casado y quiero repetir'), 'wonderful' => _('El matrimonio es algo maravilloso')}.map {|k,v| [v,k]}
  end

  def religion_activity_options
    {'essential' => _('para mi la religión es esencial en mi vida'), 'care-little' => _('me importa poco la religión'), 'not-care' => _('no me importa en absoluto la religión')}.map {|k,v| [v,k]}
  end

  def animals_options
    {'like-pets' => _('Me gustan los animales de compañía'), 'not-like-pets' => _('No me gustan los animales de compañía'), 'have-pets' => _('Tengo animales de compañía'), 'no-pets' => _('No tengo animales de compañía'), 'allergic' => _('No tengo animales de compañía y soy alérgico')}.map {|k,v| [v,k]}
  end

  def party_options
    {'like-out' => _('Me gusta mucho salir'), 'not-like-out' => _('No me gusta salir'), 'like-bars' => _('Me gusta ir de bares'), 'like-disco' => _('Me gusta ir a la discoteca'), 'like-drink-friends' => _('Me gusta ir a tomar algo con amigos'), 'love-party' => _('Me encanta la fiesta'), 'not-like-party' => _('No me gusta nada la fiesta')}.map {|k,v| [v,k]}
  end

  def music_options
    {'like-music' => _('Me gusta la música'), 'no-like-music' => _('no me gusta la música')}.map {|k,v| [v,k]}
  end

  def music_genre_options
    {'pop' => _('pop'), 'rock' => _('rock'), 'classical' => _('clásica'), 'opera' => _('ópera'), 'heavy' => _('heavy'), 'everything' => _('de todo un poco')}.map {|k,v| [v,k]}
  end

  def cinema_options
    {'like-cinema' => _('Me gusta ir al cine'), 'not-like-cinema' => _('No me gusta ir al cine')}.map {|k,v| [v,k]}
  end

  def cinema_frequency_options
    {'occasionally' => _('ocasionalemnete'), 'often' => _('muy a menudo')}.map {|k,v| [v,k]}
  end

  def cinema_genre_options
    {'romantic' => _('romántico'), 'dramas' => _('drama'), 'comedies' => _('comedia'), 'police' => _('policíaco'), 'terror' => _('terror')}.map {|k,v| [v,k]}
  end


  def lf_relationship_options
    {'friends' => _('hacer nuevas amistades'), 'fun' => _('salir y pasarlo bien'), 'couple' => _('establecer una relación estable'), 'marry' => _('casarme')}.map {|k,v| [v,k]}
  end

  def lf_house_options
    {'alone' => _('sol@'),'couple' => _('en pareja'),'with-kids' => _('con sus hijos'), 'occasionally-with-children' => _('ocasionalmente con sus hijos'),'accompanied' => _('acompañad@')}.map {|k,v| [v,k]}
  end

  def lf_child_options
    { 'have-children' => _('tenga hijos'),'no-children' => _('no tenga hijos'),'no-want-children' => _('no tenga hijos, y no quiera tener'), 'no-kids-i-want' => _('no tenga hijos, pero quiera tener'),'have-children-no-want-more' => _('tenga hijos, y no quiera tener mas '), 'have-children-want-more' => _('tenga hijos, y quiera tener mas '),'no-like-kids' => _('no le gusten los niños')}.map {|k,v| [v,k]}
  end

  def lf_smoke_options
    {'smoker' => _('fume'), 'non-smoker' => _('no fume'), 'smoker-hater' => _('sea antitabaco'), 'not-mind-smoke' => _('no le moleste el humo'), 'smoke-leave-couple' => _('fume pero lo dejaría por su pareja'), 'social-smoker' => _('sea fumador social')}.map {|k,v| [v,k]}
  end

  def lf_party_options
    {'like-out' => _('le guste mucho salir'), 'not-like-out' => _('no le guste salir'), 'like-bars' => _('le guste ir de bares'), 'like-disco' => _('le guste ir a la discoteca'), 'like-drink-friends' => _('le guste ir a tomar algo con amigos'), 'love-party' => _('le encante la fiesta'), 'not-like-party' => _('no le guste nada la fiesta')}.map {|k,v| [v,k]}
  end

  def lf_diet_options
    {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'), 'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('sea muy maniátic@ con la comida'), 'like-all' => _('le guste todo'), 'adapt' => _('se adapte fácilmente')}.map {|k,v| [v,k]}
  end

  def lf_alcohol_options
    {'when-go-out' => _('le guste beber solo cuando salga'), 'not-drink' => _('no beba alcohol'), 'occasionally' => _('beba ocasionalmente'), 'drinker' => _('sea bebedor'), 'meke-me-sick' => _('el alcohol no le sienta bien')}.map {|k,v| [v,k]}
  end

  def lf_religion_activity_options
    {'essential' => _('la religión sea esencial en su vida'), 'care-little' => _('le importe poco la religión'), 'not-care' => _('no le importe en absoluto la religión')}.map {|k,v| [v,k]}
  end

  def lf_animals_options
    {'like-pets' => _('le gusten los animales de compañía'), 'not-like-pets' => _('no le gusten los animales de compañía'), 'have-pets' => _('tenga animales de compañía'), 'no-pets' => _('no tenga animales de compañía'), 'allergic' => _('no tenga animales de compañía y sea alérgic@')}.map {|k,v| [v,k]}
  end

  def lf_child_options
    { 'have-children' => _('tenga hijos'),'no-children' => _('no tenga hijos'),'no-want-children' => _('no tenga hijos, y no quiera tener'), 'no-kids-i-want' => _('no tenga hijos, pero quiera tener'),'have-children-no-want-more' => _('tenga hijos, y no quiera tener mas '), 'have-children-want-more' => _('tenga hijos, y quiera tener mas '),'no-like-kids' => _('no le gusten los niños')}.map {|k,v| [v,k]}
  end




end
