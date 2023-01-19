CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ########## TABLES ##########
CREATE TABLE "GenreTypes" (
    "Id" SERIAL PRIMARY KEY NOT NULL,
    "NavigationId" UUID UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    "Description" VARCHAR(50) NOT NULL
);

CREATE TABLE "Movies" (
    "Id" SERIAL PRIMARY KEY NOT NULL,
    "NavigationId" UUID UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    "GenreId" INTEGER NOT NULL,
    "Title" VARCHAR(100) NOT NULL,
    "Synopsis" TEXT NOT NULL,
    "Director" VARCHAR(100) NOT NULL,
    "ReleaseYear" SMALLINT NOT NULL,

    CONSTRAINT fk_Movies_GenreTypes FOREIGN KEY ("GenreId")
    REFERENCES "GenreTypes" ("Id")
);

CREATE TABLE "MoviesDictionary" (
    "MovieId" INTEGER NOT NULL,
    "Culture" CHAR(5) NOT NULL,
    "Title" VARCHAR(100) NOT NULL,
    "Synopsis" TEXT NOT NULL,

    CONSTRAINT fk_MoviesDictionary_Movies FOREIGN KEY ("MovieId")
    REFERENCES "Movies" ("Id")
);

CREATE TABLE "GenreTypesDictionary" (
    "GenreId" INTEGER NOT NULL,
    "Culture" CHAR(5) NOT NULL,
    "Description" VARCHAR(50) NOT NULL,

    CONSTRAINT fk_GenreTypesDictionary_GenreTypes FOREIGN KEY ("GenreId")
    REFERENCES "GenreTypes" ("Id")
);

-- ########## SEEDING ##########
INSERT INTO "GenreTypes" ("Description")
VALUES
    ('Action'),
    ('Adventure'),
    ('Comedy'),
    ('Crime'),
    ('Drama'),
    ('Horror'),
    ('Musical'),
    ('Romance'),
    ('Science Fiction');

INSERT INTO "GenreTypesDictionary" ("GenreId", "Culture", "Description")
VALUES
    (1, 'en-US', 'Action'),
    (1, 'pt-BR', 'Ação'),
    (1, 'es-ES', 'Acción'),
    (2, 'en-US', 'Adventure'),
    (2, 'pt-BR', 'Aventura'),
    (2, 'es-ES', 'Aventura'),
    (3, 'en-US', 'Comedy'),
    (3, 'pt-BR', 'Comédia'),
    (3, 'es-ES', 'Comedia'),
    (4, 'en-US', 'Crime'),
    (4, 'pt-BR', 'Policial'),
    (4, 'es-ES', 'Crimen'),
    (5, 'en-US', 'Drama'),
    (5, 'pt-BR', 'Drama'),
    (5, 'es-ES', 'Drama'),
    (6, 'en-US', 'Horror'),
    (6, 'pt-BR', 'Terror'),
    (6, 'es-ES', 'Terror'),
    (7, 'en-US', 'Musical'),
    (7, 'pt-BR', 'Musical'),
    (7, 'es-ES', 'Musical'),
    (8, 'en-US', 'Romance'),
    (8, 'pt-BR', 'Romance'),
    (8, 'es-ES', 'Romántica'),
    (9, 'en-US', 'Science Fiction'),
    (9, 'pt-BR', 'Ficção Científica'),
    (9, 'es-ES', 'Ciencia Ficción');

INSERT INTO "Movies" ("GenreId", "Title", "Synopsis", "Director", "ReleaseYear")
VALUES
    (1, 'The Revenant', 'A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team.', 'Alejandro G. Iñárritu', 2015),
    (4, 'The Invisible Guest', 'A successful entrepreneur accused of murder and a witness preparation expert have less than three hours to come up with an impregnable defense.', 'Oriol Paulo', 2016),
    (3, 'Green Book', 'A working-class Italian-American bouncer becomes the driver for an African-American classical pianist on a tour of venues through the 1960s American South.', 'Peter Farrelly', 2018),
    (5, 'Hacksaw Ridge', 'World War II American Army Medic Desmond T. Doss, who served during the Battle of Okinawa, refuses to kill people and becomes the first man in American history to receive the Medal of Honor without firing a shot.', 'Mel Gibson', 2016),
    (3, 'Molly''s Game', 'The true story of Molly Bloom, an Olympic-class skier who ran the world''s most exclusive high-stakes poker game and became an FBI target.', 'Aaron Sorkin', 2017),
    (1, 'Logan', 'In a future where mutants are nearly extinct, an elderly and weary Logan leads a quiet life. But when Laura, a mutant child pursued by scientists, comes to him for help, he must get her to safety.', 'James Mangold', 2017),
    (1, 'The Accountant', 'As a math savant uncooks the books for a new client, the Treasury Department closes in on his activities, and the body count starts to rise.', 'Gavin O''Connor', 2016),
    (5, 'Lion', 'A five-year-old Indian boy is adopted by an Australian couple after getting lost hundreds of kilometers from home. 25 years later, he sets out to find his lost family.', 'Garth Davis', 2016),
    (9, 'Mad Max: Fury Road', 'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max.', 'George Miller', 2015),
    (4, 'Drishyam', 'Desperate measures are taken by a man who tries to save his family from the dark side of the law, after they commit an unexpected crime.', 'Nishikant Kamat', 2015),
    (6, 'The Nun', 'A priest with a haunted past and a novice on the threshold of her final vows are sent by the Vatican to investigate the death of a young nun in Romania and confront a malevolent force in the form of a demonic nun.', 'Corin Hardy', 2018);

INSERT INTO "MoviesDictionary" ("MovieId", "Culture", "Title", "Synopsis")
VALUES
    (1, 'en-US', 'The Revenant', 'A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team.'),
    (1, 'pt-BR', 'O Regresso', 'Um fronteiriço em uma expedição de comércio de peles na década de 1820 luta pela sobrevivência depois de ser atacado por um urso e deixado para morrer por membros de sua própria equipe de caça.'),
    (1, 'es-ES', 'El Renacido', 'Un hombre de la frontera en una expedición de comercio de pieles en la década de 1820 lucha por sobrevivir después de ser mutilado por un oso y dejado por muerto por miembros de su propio equipo de caza.'),
    (2, 'en-US', 'The Invisible Guest', 'A successful entrepreneur accused of murder and a witness preparation expert have less than three hours to come up with an impregnable defense.'),
    (2, 'pt-BR', 'O Convidado Invisível', 'Um empresário de sucesso acusado de assassinato e um especialista em preparação de testemunhas têm menos de três horas para apresentar uma defesa inexpugnável.'),
    (2, 'es-ES', 'El huésped invisible', 'Un empresario exitoso acusado de asesinato y un experto en preparación de testigos tienen menos de tres horas para presentar una defensa inexpugnable.'),
    (3, 'en-US', 'Green Book', 'A working-class Italian-American bouncer becomes the driver for an African-American classical pianist on a tour of venues through the 1960s American South.'),
    (3, 'pt-BR', 'Livro Verde', 'Um segurança ítalo-americano da classe trabalhadora torna-se o motorista de um pianista clássico afro-americano em uma turnê por locais pelo sul dos Estados Unidos da década de 1960.'),
    (3, 'es-ES', 'Libro Verde', 'Un portero italoamericano de clase trabajadora se convierte en el conductor de un pianista clásico afroamericano en una gira por lugares a través del sur de Estados Unidos de la década de 1960.'),
    (4, 'en-US', 'Hacksaw Ridge', 'World War II American Army Medic Desmond T. Doss, who served during the Battle of Okinawa, refuses to kill people and becomes the first man in American history to receive the Medal of Honor without firing a shot.'),
    (4, 'pt-BR', 'Até o Último Homem', 'O médico do Exército Americano da Segunda Guerra Mundial Desmond T. Doss, que serviu durante a Batalha de Okinawa, se recusa a matar pessoas e se torna o primeiro homem na história americana a receber a Medalha de Honra sem disparar um tiro.'),
    (4, 'es-ES', 'Al último hombre', 'El médico del ejército estadounidense de la Segunda Guerra Mundial Desmond T. Doss, que sirvió durante la Batalla de Okinawa, se niega a matar gente y se convierte en el primer hombre en la historia de Estados Unidos en recibir la Medalla de Honor sin disparar un tiro.'),
    (5, 'en-US', 'Molly''s Game', 'The true story of Molly Bloom, an Olympic-class skier who ran the world''s most exclusive high-stakes poker game and became an FBI target.'),
    (5, 'pt-BR', 'Jogo de Molly', 'A verdadeira história de Molly Bloom, uma esquiadora de classe olímpica que dirigiu o jogo de pôquer de alto risco mais exclusivo do mundo e se tornou um alvo do FBI.'),
    (5, 'es-ES', 'El juego de Molly', 'La verdadera historia de Molly Bloom, una esquiadora de clase olímpica que dirigió el juego de póquer de apuestas más exclusivo del mundo y se convirtió en un objetivo del FBI.'),
    (6, 'en-US', 'Logan', 'In a future where mutants are nearly extinct, an elderly and weary Logan leads a quiet life. But when Laura, a mutant child pursued by scientists, comes to him for help, he must get her to safety.'),
    (6, 'pt-BR', 'Logan', 'Em um futuro onde os mutantes estão quase extintos, um Logan idoso e cansado leva uma vida tranquila. Mas quando Laura, uma criança mutante perseguida por cientistas, vem até ele em busca de ajuda, ele deve levá-la para a segurança.'),
    (6, 'es-ES', 'Logan', 'En un futuro donde los mutantes están casi extintos, un anciano y cansado Logan lleva una vida tranquila. Pero cuando Laura, una niña mutante perseguida por los científicos, acude a él en busca de ayuda, él debe llevarla a un lugar seguro.'),
    (7, 'en-US', 'The Accountant', 'As a math savant uncooks the books for a new client, the Treasury Department closes in on his activities, and the body count starts to rise.'),
    (7, 'pt-BR', 'O Contador', 'À medida que um especialista em matemática descozinha os livros para um novo cliente, o Departamento do Tesouro se aproxima de suas atividades e a contagem de corpos começa a subir.'),
    (7, 'es-ES', 'El Contador', 'A medida que un sabio de las matemáticas descocina los libros para un nuevo cliente, el Departamento del Tesoro se acerca a sus actividades y el recuento de cadáveres comienza a aumentar.'),
    (8, 'en-US', 'Lion', 'A five-year-old Indian boy is adopted by an Australian couple after getting lost hundreds of kilometers from home. 25 years later, he sets out to find his lost family.'),
    (8, 'pt-BR', 'Lion', 'Um menino indiano de cinco anos é adotado por um casal australiano depois de se perder a centenas de quilômetros de casa. 25 anos depois, ele parte em busca de sua família perdida.'),
    (8, 'es-ES', 'Lion', 'Un niño indio de cinco años es adoptado por una pareja australiana después de perderse a cientos de kilómetros de su casa. 25 años después, se dispone a encontrar a su familia perdida.'),
    (9, 'en-US', 'Mad Max: Fury Road', 'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max.'),
    (9, 'pt-BR', 'Mad Max: Estrada da Fúria', 'Em um deserto pós-apocalíptico, uma mulher se rebela contra um governante tirânico em busca de sua terra natal com a ajuda de um grupo de prisioneiras, um adorador psicótico e um andarilho chamado Max.'),
    (9, 'es-ES', 'Mad Max: Camino de la Furia', 'En un páramo post-apocalíptico, una mujer se rebela contra un gobernante tiránico en busca de su tierra natal con la ayuda de un grupo de prisioneras, un adorador psicótico y un vagabundo llamado Max.'),
    (10, 'en-US', 'Drishyam', 'Desperate measures are taken by a man who tries to save his family from the dark side of the law, after they commit an unexpected crime.'),
    (10, 'pt-BR', 'A Chantagem', 'Um homem toma medidas desesperadas para tentar salvar sua família do lado negro da lei depois que eles cometem um crime inesperado.'),
    (10, 'es-ES', 'Drishyam', 'Un hombre toma medidas desesperadas que intentan salvar a su familia del lado oscuro de la ley, luego de que cometen un crimen inesperado.'),
    (11, 'en-US', 'The Nun', 'A priest with a haunted past and a novice on the threshold of her final vows are sent by the Vatican to investigate the death of a young nun in Romania and confront a malevolent force in the form of a demonic nun.'),
    (11, 'pt-BR', 'A Freira', 'Um sacerdote e uma noviça são enviados pelo Vaticano a investigar a morte duma joven freira e se confrontar com uma demoníaca força.'),
    (11, 'es-ES', 'La monja', 'Un sacerdote con un pasado maldito y una novicia en el umbral de sus últimos votos son enviados por el Vaticano para investigar la muerte de una joven monja en Rumanía y enfrentarse a una fuerza malévola en forma de monja demoníaca.');