#encoding: utf-8
module UserConstants
  extend ActiveSupport::Concern

  GENDER = {'male' => _('hombre'), 'female' => _('mujer')}
  SEEKING = {'man seeking woman' => _('hombre buscando una mujer'), 'woman seeking man' => _('mujer buscando un hombre'), 'man seeking man' => _('hombre buscando un hombre'), 'woman seeking woman' => _('mujer buscando una mujer')}
  MARITAL_STATUS = {'single' => _('solter@'),'engaged' => _('ocupad@'), 'separated' => _('separad@'), 'divorced' => _('divorciad@'), 'married' => _('casad@'), 'widowed' => _('viud@')}
  CHILD = { 'have-children' => _('tengo hijos'),'no-children' => _('no tengo hijos'),'no-want-children' => _('no tengo hijos, y no quiero tener'), 'no-kids-i-want' => _('no tengo hijos, pero quiero tener'),'have-children-no-want-more' => _('si tengo hijos, y no quiero tener mas '), 'have-children-want-more' => _('si tengo hijos, y quiero tener mas '),'no-like-kids' => _('no me gustan los niños')}
  HOUSE = {'alone' => _('sol@'),'couple' => _('en pareja'),'with-kids' => _('con mis hijos'), 'occasionally-with-children' => _('ocasionalmente con mis hijos'),'accompanied' => _('acompañad@'), 'with-parents' => _('con mis padres')}
  PHYSICAL_DESC = {'normal' => _('normal'), 'sexy' => _('atractiv@'), 'pretty' => _('guap@'), 'of-the-mill' => _('del montón')}
  PHYSICAL_STYLE = {'bohemian' => _('bohemio'), 'classic' => _('clásico'),'indie/casual' => _('indie/casual'), 'sport' => _('deportivo'),'formal' => _('formal'), 'trendy' => _('a la moda'),'rocker' => _('rockero'), 'preppy' => _('pijo')}
  EYES = {'brown' => _('marrón'),'black' => _('negro'),'green' => _('verde'),'gray' => _('gris'),'coffee' => _('café'),'blue' => _('azul')}
  HAIR = {'blond' => _('rubio'),'redhead' => _('pelirrojo'),'gray' => _('gris'),'brown' => _('marrón'),'black' => _('negro')}
  HAIR_STYLE = {'short' => _('corto'),'very short' => _('muy corto'),'large' => _('largo'),'shaved' => _('afeitado'), 'hairless' => _('sin pelo')}
  COMPLEXION = {'thin' => _('delgado'), 'normal' => _('normal'), 'nice' => _('muy bien'), 'athletic' => _('atlético'), 'strong' => _('fuerte'),  'curvy' => _('con curvas'), 'obese' => _('obeso')}
  SMOKE = {'smoker' => _('Fumo'), 'non-smoker' => _('No fumo'), 'smoker-hater' => _('Soy antitabaco'),'not-mind-smoke' => _('No me molesta el humo'), 'smoke-leave-couple' => _('Fumo pero lo dejaría por mi pareja'), 'social-smoker' => _('Soy fumador social')}
  RELIGION = {'agnostic' => _('agnóstico'), 'atheist' => _('ateo'), 'christian' => _('cristiano'), 'jewish' => _('judío'), 'catholic' => _('católico'), 'muslim' => _('musulmán'), 'hindu' => _('indú'), 'buddhist' => _('budista')}
  ETHNICITY = {'hispanic' => _('hispana'), 'arab' => _('árabe'), 'indian' => _('india'), 'european' => _('europea'), 'african' => _('africana'), 'asian' => _('asiática') }
  STUDY_LEVEL = {'school' => _('instituto o inferior'), 'high-school' => _('bachillerato'),'certified' => _('diplomado'), 'professional' => _('módulo profesional'), 'graduate' => _('licenciado o superior')}
  LANGUAGE = { 'english' => _('Inglés'), 'spanish' => _('Español'), 'french' => _('Francés'), 'italian' => _('Italiano'), 'other' => _('otro') }
  LANGUAGE_LEVEL = { 'low' => _('bajo'), 'medium' => _('medio'), 'hight' => _('alto') }
  JOB = {'artistic' => _('trabajos artísticos y creativos '),'banking' => _('banca, financiero'),'administrative' => _('adminsitrativo'), 'technology' => _('ordenadores y tecnología'),'construction' => _('construcción'),'education' => _('educación'), 'advertising' => _('publicidad, entretenimiento y medios'),'management' => _('ejecutivo y gestión '),'health'=> _('salud'), 'travel' => _('viajes'),'legal' => _('servicios legales'),'military' => _('militar'),'employee' => _('empleado'), 'public-employee' => _('empleado público / gobierno'),'science' => _('ciencia'), 'sales' => _('ventas y márketing'), 'transportation' => _('transporte y logística '),'unemployed' => _('desempleado'),'retired' => _('jubilado'), 'retired-temporarily' => _('retirado temporalmente'),'studying' => _('estoy estudiando')}
  DIET = {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'), 'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('soy muy maniátic@ con la comida'), 'like-all' => _('me gusta todo'), 'adapt' => _('me adapto fácilmente')}
  ALCOHOL = {'when-go-out' => _('me gusta beber solo cuando salgo'), 'not-drink' => _('no bebo alcohol'), 'occasionally' => _('bebo ocasionalmente'), 'drinker' => _('soy bebedor'), 'meke-me-sick' => _('el alcohol no me sienta bien')}
  WEDDING_OPINION = {'would-marry' => _('Me gustaría casarme'), 'would-not-marry' => _('No me gustaría casarme'), 'not-believe' => _('No creo en el matrimonio'), 'married-no-repeat'=> _('Ya he estado casado y no quiero repetir'), 'married-repeat' => _('Ya he estado casado y quiero repetir'), 'wonderful' => _('El matrimonio es algo maravilloso')}
  RELIGION_ACTIVITY = {'essential' => _('para mi la religión es esencial en mi vida'), 'care-little' => _('me importa poco la religión'), 'not-care' => _('no me importa en absoluto la religión')}
  ANIMALS = {'like-pets' => _('Me gustan los animales de compañía'), 'not-like-pets' => _('No me gustan los animales de compañía'), 'have-pets' => _('Tengo animales de compañía'), 'no-pets' => _('No tengo animales de compañía'), 'allergic' => _('No tengo animales de compañía y soy alérgico')}
  PARTY = {'like-out' => _('Me gusta mucho salir'), 'not-like-out' => _('No me gusta salir'), 'like-bars' => _('Me gusta ir de bares'), 'like-disco' => _('Me gusta ir a la discoteca'), 'like-drink-friends' => _('Me gusta ir a tomar algo con amigos'), 'love-party' => _('Me encanta la fiesta'), 'not-like-party' => _('No me gusta nada la fiesta')}
  MUSIC = {'like-music' => _('Me gusta la música'), 'no-like-music' => _('no me gusta la música')}
  MUSIC_GENRE = {'pop' => _('pop'), 'rock' => _('rock'), 'classical' => _('clásica'), 'opera' => _('ópera'), 'heavy' => _('heavy'), 'everything' => _('de todo un poco')}
  CINEMA = {'like-cinema' => _('Me gusta ir al cine'), 'not-like-cinema' => _('No me gusta ir al cine')}
  CINEMA_FREQUENCY = {'occasionally' => _('ocasionalemnete'), 'often' => _('muy a menudo')}
  CINEMA_GENRE = {'romantic' => _('romántico'), 'dramas' => _('drama'), 'comedies' => _('comedia'), 'police' => _('policíaco'), 'terror' => _('terror')}


  # LOOKING FOR OPTIONS
  LF_RELATIONSHIP = {'friends' => _('hacer nuevas amistades'), 'fun' => _('salir y pasarlo bien'), 'couple' => _('establecer una relación estable'), 'marry' => _('casarme')}
  LF_HOUSE = {'alone' => _('sol@'),'couple' => _('en pareja'),'with-kids' => _('con sus hijos'), 'occasionally-with-children' => _('ocasionalmente con sus hijos'),'accompanied' => _('acompañad@')}
  LF_SMOKE = {'smoker' => _('fume'), 'non-smoker' => _('no fume'), 'smoker-hater' => _('sea antitabaco'), 'not-mind-smoke' => _('no le moleste el humo'), 'smoke-leave-couple' => _('fume pero lo dejaría por su pareja'), 'social-smoker' => _('sea fumador social')}
  LF_ALCOHOL = {'when-go-out' => _('le guste beber solo cuando salga'), 'not-drink' => _('no beba alcohol'), 'occasionally' => _('beba ocasionalmente'), 'drinker' => _('sea bebedor'), 'meke-me-sick' => _('el alcohol no le sienta bien')}
  LF_PARTY = {'like-out' => _('le guste mucho salir'), 'not-like-out' => _('no le guste salir'), 'like-bars' => _('le guste ir de bares'), 'like-disco' => _('le guste ir a la discoteca'), 'like-drink-friends' => _('le guste ir a tomar algo con amigos'),'love-party' => _('le encante la fiesta'), 'not-like-party' => _('no le guste nada la fiesta')}
  LF_DIET = {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'), 'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('sea muy maniátic@ con la comida'), 'like-all' => _('le guste todo'), 'adapt' => _('se adapte fácilmente')}
  LF_RELIGION_ACTIVITY = {'essential' => _('la religión sea esencial en su vida'), 'care-little' => _('le importe poco la religión'), 'not-care' => _('no le importe en absoluto la religión')}
  LF_ANIMALS = {'like-pets' => _('le gusten los animales de compañía'), 'not-like-pets' => _('no le gusten los animales de compañía'), 'have-pets' => _('tenga animales de compañía'), 'no-pets' => _('no tenga animales de compañía'), 'allergic' => _('no tenga animales de compañía y sea alérgic@')}
  LF_CHILD = { 'have-children' => _('tenga hijos'),'no-children' => _('no tenga hijos'),'no-want-children' => _('no tenga hijos, y no quiera tener'), 'no-kids-i-want' => _('no tenga hijos, pero quiera tener'),'have-children-no-want-more' => _('tenga hijos, y no quiera tener mas '), 'have-children-want-more' => _('tenga hijos, y quiera tener mas '),'no-like-kids' => _('no le gusten los niños')}

  # THIRD PERSON OPTIONS
  TP_CHILD = { 'have-children' => _('tiene hijos'),'no-children' => _('no tiene hijos'),'no-want-children' => _('no tiene hijos, y no quiere tener'), 'no-kids-i-want' => _('no tiene hijos, pero quiere tener'),'have-children-no-want-more' => _('tiene hijos, y no quiere tener mas '), 'have-children-want-more' => _('si tiene hijos, y quiere tener mas '),'no-like-kids' => _('no le gustan los niños')}
  TP_HOUSE = {'alone' => _('sol@'),'couple' => _('en pareja'),'with-kids' => _('con sus hijos'), 'occasionally-with-children' => _('ocasionalmente con sus hijos'),'accompanied' => _('acompañad@'), 'with-parents' => _('con sus padres')}
  TP_SMOKE = {'smoker' => _('fuma'), 'non-smoker' => _('no fuma'), 'smoker-hater' => _('es antitabaco'), 'not-mind-smoke' => _('no le molesta el humo'), 'smoke-leave-couple' => _('fuma pero lo dejaría por su pareja'), 'social-smoker' => _('es fumador social')}
  TP_DIET = {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'), 'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('es muy maniátic@ con la comida'),
    'like-all' => _('le gusta todo'), 'adapt' => _('se adapta fácilmente')}
  TP_ALCOHOL = {'when-go-out' => _('le gusta beber solo cuando sale'), 'not-drink' => _('no bebe alcohol'), 'occasionally' => _('bebe ocasionalmente'), 'drinker' => _('es bebedor'), 'meke-me-sick' => _('el alcohol no le sienta bien')}
  TP_WEDDING_OPINION = {'would-marry' => _('le gustaría casarse'), 'would-not-marry' => _('no le gustaría casarse'), 'not-believe' => _('no cree en el matrimonio'), 'married-no-repeat'=> _('ya ha estado casad@ y no quiere repetir'), 'married-repeat' => _('ya ha estado casad@ y quiere repetir'), 'wonderful' => _('el matrimonio es algo maravilloso')}
  TP_RELIGION_ACTIVITY = {'essential' => _('la religión es esencial en su vida'), 'care-little' => _('le importa poco la religión'), 'not-care' => _('no le importa en absoluto la religión')}
  TP_ANIMALS = {'like-pets' => _('le gustan los animales de compañía'), 'not-like-pets' => _('mo le gustan los animales de compañía'), 'have-pets' => _('tiene animales de compañía'), 'no-pets' => _('no tiene animales de compañía'), 'allergic' => _('no tiene animales de compañía y es alérgic@')}
  TP_PARTY = {'like-out' => _('le gusta mucho salir'), 'not-like-out' => _('no le gusta salir'), 'like-bars' => _('le gusta ir de bares'), 'like-disco' => _('le gusta ir a la discoteca'), 'like-drink-friends' => _('le gusta ir a tomar algo con amigos'), 'love-party' => _('le encanta la fiesta'), 'not-like-party' => _('no me gusta nada la fiesta')}
  TP_MUSIC = {'like-music' => _('le gusta la música'), 'no-like-music' => _('no le gusta la música')}
  TP_CINEMA = {'like-cinema' => _('Me gusta ir al cine'), 'not-like-cinema' => _('no me gusta ir al cine')}

  PICTURE_LIMIT = 12
  DEFAULT_SEARCH_DISTANCE = 250
  DEFAULT_NEARBY_DISTANCE = 250

  # Points for the Cellove index
  CELLOVE_USER_VISIT = 1
  CELLOVE_LIKE = 1
  CELLOVE_FIRST_MESSAGE = 3
  CELLOVE_FIRST_ACTIVITY_PROPOSAL = 3
  CELLOVE_3_STARS = 1
  CELLOVE_4_STARS = 2
  CELLOVE_5_STARS = 3
  CELLOVE_IS_NICE_COUPLE = 3
  CELLOVE_RECOMMENDED_USER = 5
  CELLOVE_CELESTINO_FAMILY = 5
  CELLOVE_CELESTINO_FRIEND = 6
  CELLOVE_CELESTINO_SPECIAL_FRIEND = 8
  CELLOVE_CELESTINO_EX_PARTNER = 10
end
