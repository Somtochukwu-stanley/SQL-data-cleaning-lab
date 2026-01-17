select *
from titanic;


update titanic
set Name = substring_index(substring_index(Name, ',', -1), '(', 1) ;

with heart as (
select *, row_number() over(partition by PassengerId) as row_num
from titanic
)
select *
from heart
where row_num = 2
;



CREATE TABLE `titanic2` (
  `PassengerId` int DEFAULT NULL,
  `Survived` int DEFAULT NULL,
  `Citizen_Status` int DEFAULT NULL,
  `Name` text,
  `Sex` text,
  `Age` int DEFAULT NULL,
  `No_of_siblings_aboard` int DEFAULT NULL,
  `Parents_&_children` int DEFAULT NULL,
  `Ticket` text,
  `Ticket_Fare` double DEFAULT NULL,
  `Cabin_number` text,
  `PortEmbarked` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from titanic2;


insert into titanic2
select *
from titanic;


select *
from titanic2;


select *, substring_index(Name, ' ', 4) 
from titanic2;


update titanic2
set Name = substring_index(Name, ' ', 4) ;



select *
from titanic2;


select*, format(Ticket_Fare, 2) as rounded_fare
from titanic2;


update titanic2
set Ticket_fare = format(Ticket_Fare, 2);






select *
from titanic2;















#Update titanic
#set Name = replace(replace(Name, ')', ' ' ), '(', '');


#select *, substring_index(Name, ',', 1), substring_index(Name, ',', -1)
#from titanic;



#with new_one as (
#select*, length(Name) =30 as new_name
#from titanic)
#select Name, new_name
#from new_one
#where new_name=1;






#select *, substring_index(Name, ',', 1) as Nickname, 
#substring_index(substring_index(Name, ',', -1), '(', 1) as Real_Name, 
#Trim(Both '(' from substring_index(substring_index(Name, '(', -1), ')', 1)) as Bracket_Names
#from titanic;









#where Name like '%Mrs. (%'



#WITH RECURSIVE split_cte AS (
 #  id,
  #  SUBSTRING_INDEX(YourColumn, ',', 1) AS SplitValue,
   # SUBSTRING(YourColumn, LENGTH(SUBSTRING_INDEX(YourColumn, ',', 1)) + 2) AS Remainder
  #FROM YourTable
  #UNION ALL
  #SELECT 
   # id,
    #SUBSTRING_INDEX(Remainder, ',', 1),
    #SUBSTRING(Remainder, LENGTH(SUBSTRING_INDEX(Remainder, ',', 1)) + 2)
  #FROM split_cte
  #WHERE Remainder <> ''
#)
#SELECT id, SplitValue FROM split_cte;
