use [C:\USERS\JOAON\DOCUMENTS\FITCHEF.MDF]; 

INSERT INTO utilizador
	(username, pass, nome, email, tipo)
	VALUES  
    ('johhny99','gata2019','João Nunes','johnny@gmail.com',0), 
    ('bragin','dimitry','Luís Braga','braga@gmail.com',1), 
    ('salizad','balbex','Shahzod Yusupov','junior@gmail.com',1), 
    ('luisinho','lewis','Luís Martins','luis_green@gmail.com',1); 

INSERT INTO receita
	(nome, infNutricional)
    VALUES
    ('Chicken Salad', 100);

INSERT INTO utensilio 
	(nome)
    VALUES
	('Frying pan'),
    ('Soup spoon'),
    ('Dessert spoon'),
    ('Knife'),
    ('Serving bowl'),
    ('Spatula'),
    ('Funnel'),
    ('Spoon'),
    ('Fork'),
    ('Drainer'),
    ('Grater'),
    ('Food mixer');

INSERT INTO Ingrediente
	(nome, unidade)
    VALUES
	('Chicken Breast',        'gr'),
    ('Garlic cloves',         'unit/s'),
    ('Oregano',               'enough'),
    ('Lemon',                 'unit/s'),
    ('Sweet Chili',           'enough'),
    ('Salt',                  '1,5 dess. spoon'),
    ('Black Pepper',          'enough'),
    ('Olive Oil',             '3 soup spoon'),
    ('Gourmet salad mixture', 'Package'),
    ('Wild arugula',          'Package'),
    ('Cherry Tomato',         'gr'),
    ('Cucumber',              'gr'),
    ('Walnut kernels',        'gr'),
    ('Fresh basil leaves',    'enough');
    
INSERT INTO Passo
	(Descricao)
    VALUES
    ('Have the chicken at room temperature 20 minutes before cooking. Season it with chopped garlic, oregano, sweet pepper, juice of half lemon and 1 tablespoon of salt and as much pepper as you like.'),
    ('Bring to the heat a frying pan with a tablespoon of olive oil and stir the chicken breasts on both sides for 10 minutes. Remove from the heat and cut the chicken into small pieces.'),
    ('In a serving bowl or in individual servings, place the gourmet lettuce mixture, the arugula, the cherry tomatoes cutted into halves and the cucumber into half-moons.'),
    ('Chop the walnuts roughly and distribute them in the salad.'),
    ('Add the chicken and season with the lemon juice, olive oil and salt.'),
    ('Garnish with fresh basil leaves.');

INSERT INTO Explicacao
	(url, video, duvida, Passo_id)
    VALUES
    ('https://www.wikihow.com/video/2/20/Mince%20Garlic%20Step%206.360p.mp4',    1, 'how to chop garlic,chop garlic',                                  1),
    ('https://www.wikihow.com/video/3/31/Juice%20a%20Lemon%20Step%204.360p.mp4', 1, 'how to make lemon juice,lemon juice',                           1),
    ('https://www.wikihow.com/video/c/c1/Brown%20Chicken%20Step%204.360p.mp4',   1, 'stir fry with a spoonful of olive oile, dtyr fry with olive oil', 2),
    ('https://www.wikihow.com/video/3/3a/Brown%20Chicken%20Step%208.360p.mp4',   1, 'stir the chicken breasts,stir the chicken',                     2),
    ('https://st3.depositphotos.com/4460317/19221/v/600/depositphotos_192212528-stock-video-female-hand-cut-a-piece.jpg', 0, 'cut chicken into small pieces,cut the chicken', 2),
    ('https://www.wikihow.com/images_en/thumb/f/fd/Slice-a-Tomato-Step-4-Version-2.jpg/v4-728px-Slice-a-Tomato-Step-4-Version-2.jpg.webp', 0, 'cut cherry tomatoes to halves,tomate às metades,cut tomatoes to halves', 3),
    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJRxMNRm_uEebx5iPe9YgHXDKTkOBI3BDw0Jw6T1wEDE3-qrN8', 0, 'cut cucumber to half moons,cut to half moons,vegetables to half moons', 3),
    ('https://www.bluehendesoesterreich.at/wp-content/uploads/2017/04/nusse-hacken.jpg', 0, 'how to chop nuts,chop nuts', 4),
    ('https://www.wikihow.com/video/e/ec/Season%20a%20Steak%20Step%205.360p.mp4', 1, 'season the chicken,season chicken,season meat', 5);

INSERT INTO Cliente_preferencia
	(Utilizador_id, Ingrediente_id, gosto)
    VALUES
    (2, 1, 1), 
    (3, 11, 1),
    (4, 3, 0);  
    
INSERT INTO Cliente_Receita
	(Utilizador_id, Receita_id, tempo_medio, quantas)
    VALUES
    (3, 1, '00:18:23',3),
    (4, 1, '00:16:34',1),
    (2, 1, '00:17:16',2);
       
INSERT INTO Dificuldade
	(comentario,Realizar_id)
    VALUES
    ('Delicious recipe! Cant wait for more!', 2),
    ('I didnt understand very well how much lemon juice I had to use.', 1);

INSERT INTO Receita_Utensilio
	(Receita_id, Utensilio_id)
    VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5);
    
INSERT INTO Receita_Passo_Ingrediente
	(Receita_id, Ingrediente_id, Passo_id, quantidade, Ordem)
    VALUES
    (1, 1,  1, 200,  1), 
    (1, 2,  1, 2,    1), 
    (1, 3,  1, 1,    1), 
    (1, 4,  1, 1,    1), 
    (1, 5,  1, 1,    1), 
    (1, 6,  1, 1,    1), 
    (1, 7,  1, 1,    1),
    (1, 1,  2, 200,  2),
    (1, 8,  2, 1,    2), 
    (1, 9,  3, 1,    3), 
    (1, 10, 3, 0.5,  3), 
    (1, 11, 3, 100,  3), 
    (1, 12, 3, 50,   3), 
    (1, 13, 4, 50,   4), 
    (1, 1,  5, 200,  5), 
    (1, 4,  5, 1,    5), 
    (1, 8,  5, 1,    5), 
    (1, 6,  5, 0.5,  5), 
    (1, 14, 6, 1,    6); 
    