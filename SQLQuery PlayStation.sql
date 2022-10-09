----Select *
--from [dbo].['playstation2_games_A-K#CVS$']


--Select Developer, Publisher, Count (Developer) AS Count_Developer
--from [dbo].['playstation2_games_A-K#CVS$']
--Group By Developer, Publisher
--ORDER BY Count_Developer ASC, Developer DESC

--Select JP,NA, COUNT(JP)
--from [dbo].['playstation2_games_A-K#CVS$']
--Group By JP, NA

/* Joins Attempts */
SELECT ['playstation2_games_A-K#CVS$'].Developer, ['playstation2_games_A-K#CVS$'].Title, ['playstation2_games_A-K#CVS$'].[First released]
FROM [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Full Outer Join [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
	ON ['playstation2_games_A-K#CVS$'].F1 =['playstation2_games_L-Z$'].F1
Where ['playstation2_games_A-K#CVS$'].Developer = 'Capcom' AND ['playstation2_games_A-K#CVS$'].Title >= 'Devil May Cry'
Order by [First released]

/* UNION Attempts */

SELECT *
FROM [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
WHERE Developer = 'Acquire'
UNION
SELECT *
FROM [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
WHERE Developer = 'Acquire'
Order by [First released]

/* CASE statements Attempts */

SELECT *
FROM [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Full Outer Join [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
	ON ['playstation2_games_A-K#CVS$'].F1 =['playstation2_games_L-Z$'].F1

SELECT Title, Publisher, [First released], JP, [EU/PAL],
Case
	WHEN Publisher = 'Koei' THEN 'Check'
	ELSE 'Not Check'
END
FROM [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Where Title Like '%Samurai%'


/* Having statements */

SELECT Publisher, count(Publisher)
FROM [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Group by Publisher
Having Publisher = 'Bandai'
UNION 
SELECT Publisher, count(Publisher)
FROM [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Group by Publisher
Having Publisher = 'Bandai'

/* UNION Attempts */

SELECT *
FROM [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
WHERE Developer = 'Acquire'
UNION
SELECT *
FROM [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
WHERE Developer = 'Acquire'
Order by [First released]

Select F1, Title, Developer, Publisher, SUBSTRING([First released],1,LEN([First released])-3) As [First released],
JP, [EU/PAL], NA
FROM [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']

Select *
FROM [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$'] 

/*
Data Cleaning
*/

/* Let join both tables. I eliminated F1 column because was not relevant for this union.
 I used union in both tables and reduced from 4493 to 4491 eliminating any duplicate.*/

Select Title, Developer, Publisher, [First released], JP, [EU/PAL], NA
From [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Union 
Select Title, Developer, Publisher, [First released], JP, [EU/PAL], NA
From [Playstation 2 Data].dbo.['playstation2_games_L-Z$']

/* Using 'is not null' and 'is null' but found none empty row in both tables */

Select Title, Developer, Publisher, [First released], JP, [EU/PAL], NA
From [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Where Title is  null
Union 
Select Title, Developer, Publisher, [First released], JP, [EU/PAL], NA
From [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Where Title is  null

/* Using Substring to eliminate First released date and JP,EU/PAL, and NA */
Select Title, Developer, Publisher, SUBSTRING([First released],1,10) As [First released]
, JP, [EU/PAL], NA
From [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Union 
Select Title, Developer, Publisher, SUBSTRING([First released],1,10) As [First released]
, JP, [EU/PAL], NA
From [Playstation 2 Data].dbo.['playstation2_games_L-Z$']



/* Update First released 2008?09EU to 2008-05-30 */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
SET [First released] = '2008-05-30'
WHERE Title = 'Chess Crusade' AND Developer = 'Slam Games'

/* Update, I could not find a specific date, so I use the ones with date. For PAL A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2007-02-23'
Where Title = 'Air Raid 3' AND Developer = 'Phoenix Games'

/* Update, I found a specific date though difficult. for PAL A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006-10-2'
Where Title = 'Animal Soccer World' AND Developer = 'The Code Monkeys'

/* Update, . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006-11-29'
Where Title = 'Beverly Hills Cop' AND Developer = 'Atomic Planet Entertainment'

/* Update, wrong date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2007-02-26'
Where Title = 'Biathlon 2008' AND Developer = '49Games'

/* Update, found the date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2004-02-27'
Where Title = 'Bad Boys: Miami Takedown' AND Developer = 'Blitz Games'

/* Update, found the date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2007'
Where Title = 'Cartoon Kingdom' AND Developer = 'Phoenix Games'

/* Update, found the date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2007'
Where Title = 'CaveMan Rock' AND Developer = 'Phoenix Games'

/* Update, found the date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006-04-07'
Where Title = 'CaveMan Rock' AND Developer = 'Phoenix Games'

/* Update, found the date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006-04-07'
Where Title = 'Cocoto Funfair' AND Developer = 'Neko Entertainment'

/* Update, found the year . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Cocoto Tennis Master' AND Developer = 'Neko Entertainment'

/* Update, found the date was incorrect . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2004-04-09'
Where Title = 'Countryside Bears' AND Developer = 'Phoenix Games'

/* Update, found the year . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Dalmatians 3' AND Developer = 'The Code Monkeys'

/* Update, found the date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2004-11-17'
Where Title = 'Dinosaur Adventure' AND Developer = 'Phoenix Games'

/* Update, found the date . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2007-10-02'
Where Title = 'Jumanji' AND Developer = 'Atomic Planet Entertainment'

/* Update, found the year only . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Kiddies Party Pack' AND Developer = 'Phoenix Games'

/* Update, found the year only . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Empire of Atlantis' AND Developer = 'Phoenix Games'

/* Update, found the year only . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2003-08-19'
Where Title = 'European Tennis Pro' AND Developer = 'Magical Company'

/* Update, found the year only . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2005-04-15'
Where Title = 'Extreme Sprint 3010' AND Developer = 'Phoenix Games'

/* Update, found the year only . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2005-04-15'
Where Title = 'Extreme Sprint 3010' AND Developer = 'Phoenix Games'

/* Update, found the year only . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2007'
Where Title = 'Finkles World' AND Developer = 'Phoenix Games'

/* Update, found the date  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2005-03-18'
Where Title = 'Fruitfall' AND Developer = 'Phoenix Games'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Games Galaxy 2' AND Developer = 'Phoenix Games'

/* Update, found the date  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2005-07-29'
Where Title = 'Girl Zone' AND Developer = 'Mere Mortals'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2005-07-29'
Where Title = 'Girl Zone' AND Developer = 'Mere Mortals'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006-04-28'
Where Title = 'Guerrilla Strike' AND Developer = 'Phoenix Games'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2005-08-08'
Where Title = 'Habitrail Hamster Ball' AND Developer = 'Data Design Interactive'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Hoppie' AND Developer = 'Phoenix Games'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2003'
Where Title = 'Inspector Gadget: Mad Robots Invasion' AND Developer = 'Silmarils'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Jackpot Madness' AND Developer = 'Dorasu'

/* Update, found the year  . for EU A-K dataset */
Update [Playstation 2 Data].dbo.['playstation2_games_A-K#CVS$']
Set [First released] = '2006'
Where Title = 'Jello' AND Developer = 'Phoenix Games'


/* Update for L-Z */


Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007'
Where Title = 'Legend of Camelot' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007'
Where Title = 'Legend of Herkules' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007'
Where Title = 'Mambo' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006'
Where Title = 'Mighty Mulan' AND Developer = 'The Code Monkeys'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007'
Where Title = 'Ocean Commander' AND Developer = 'CyberPlanet Interactive'


/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2005'
Where Title = 'The Ultimate TV & Film Quiz' AND Developer = 'Oxygen Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007'
Where Title = 'Offroad Extreme!' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007'
Where Title = 'Peter Pan' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2005-07-15'
Where Title = 'Superbike GP' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006'
Where Title = 'The Toys Room' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006'
Where Title = 'Turbo Trucks' AND Developer = 'Phoenix Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2005'
Where Title = 'The Ultimate Sport Quiz' AND Developer = 'Oxygen Games'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2001'
Where Title = 'Versailles II: Testament of the King' AND Developer = 'Cryo Interactive'

/* Update for L-Z, year only */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007'
Where Title = 'Wacky Zoo GP' AND Developer = 'Phoenix Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006-07-28'
Where Title = 'WWC: World Wrestling Championship' AND Developer = 'Phoenix Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2007-06-30'
Where Title = 'Pro Biker 2' AND Developer = 'Phoenix Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006'
Where Title = 'Retro' AND Developer = 'Aqua Pacific'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2002-11-30'
Where Title = 'RTL Ski Jumping 2003' AND Developer = 'RTL'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2005-11-17'
Where Title = 'RTL Ski Jumping 2006' AND Developer = '49Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006-04-14'
Where Title = 'Search & Destroy' AND Developer = 'Phoenix Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006-04-14'
Where Title = 'RTL Biathlon 2007' AND Developer = '49Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006-04-14'
Where Title = 'RTL Biathlon 2007' AND Developer = '49Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2008'
Where Title = 'SingStar Italian Party 2' AND Developer = 'London Studio'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2008-01-01'
Where Title = 'SingStar: Morangos com Acucar' AND Developer = 'London Studio'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006'
Where Title = 'Sol Divide' AND Developer = 'Psikyo'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006-12-31'
Where Title = 'Son of The Lion King' AND Developer = 'Phoenix Games'


/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006'
Where Title = 'Speed Machines III' AND Developer = 'Phoenix Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2006'
Where Title = 'Speedboat GP' AND Developer = 'Phoenix Games'

/* Update for L-Z, date */
Update [Playstation 2 Data].dbo.['playstation2_games_L-Z$']
Set [First released] = '2009'
Where Title = 'Real Madrid: The Game' AND Developer = 'Atomic Planet Entertainment'