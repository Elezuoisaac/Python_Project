--The following contains guides to apprehend the culprit.

--select all murders from the crime_scene_report
select *
from crime_scene_report

--filter to murders on the 15th of jan 2018 in sql city (which we vaguely remember from the description given)
select *
from crime_scene_report
where city ='SQL City' and type='murder' date=20180115

--Check for the description of the culprit
select description
from crime_scene_report
where city ='SQL City' and type='murder' and date=20180115

--Search through the person table with the given description 
--To find who is living in the last house on Northwestern Dr as given by the first suspect,use the address number
select name,max(address_number),address_street_name
from person
where address_street_name='Northwestern Dr'

--Find Annabel living in Franklin Ave
select *
from person
where name like 'Annabel%' and address_street_name='Franklin Ave'

--We proceed to the interview table to find Annabel and Morty explanations
--Annabel
select *
from interview
where person_id = 16371;

--Morty
select *
from interview
where person_id = 14887

--Morty said I heard a gunshot and then saw a man run out. 
--He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". 
--Only gold members have those bags. The man got into a car with a plate that included "H42W"

--Based of Morty's explanation,find members with membership_id starting with '48Z' and have gold membership
select *
from get_fit_now_member
where id like '48z%' and membership_status='gold' 
--Jeremy Bowers and Joe Germuska

--People with 'H42W' included in their Number plate
select *
from drivers_license
where plate_number like '%H42W%'

--use license id to find the name of the members in the person table
--Jeremy Bowers
select *
from person
where license_id =423327

--Maxine whitely
select *
from person
where license_id =183779

--Tushar Chandra
select *
from person
where license_id =664760

--Based of what Morty said Jeremy Bowers fits both description


--Annabel said she saw the murder happen, and she recognized the killer from her gym when she was working out last week on January the 9th.
--Go through the get_fit_now_check_in to see who was at the gym on the 9th of january
select *
from get_fit_now_check_in
where check_in_date =20180109

--From the previous step,i found out there were 2 people in the gym with membership_id starting with '48z'
select *
from get_fit_now_check_in
where check_in_date=20180109 and membership_id like '48Z%'

--Go through the membership table to find members with id stated above
select *
from get_fit_now_member
where id = '48Z7A'

select *
from get_fit_now_member
where id ='48Z55'

--This leaves me with Joe Germuska and Jeremy Bowers
--Jeremy Bowers also named by Morty Schapiro which makes him my prime suspect

--Further investigations to find who sent Jeremy,we recall the interview table to find jeremy's Transcript
select Transcript
from interview
where person_id = 67318

--He said he was hired by a woman who is around 5'5" (65") or 5'7" (67) has red hair ,also drives a Tesla Model S. Attended the SQL Symphony Concert 3 times in December 2017
--we head back to the drivers_license table to find women who own a Tesla and have red hair
select * 
from drivers_license
where car_model ='Model S' and hair_color='red' and gender ='female'

--This leaves us with 3 women with red colored hair,height between 65-67 and also drive a Tesla Model S
--We have to narrow our search down by finding out which of them attended the SQL symphony concert 3 times in December 2017.
--We look through the facebook_events_checkin table
select person_id ,count(person_id) as freq,event_name
from facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert' and date like '%201712%'
group by person_id
order by freq desc
limit 2

--This leaves us with 2 suspects with person_id number-99716,24556
--We head  back the person table to find the names of people with above mentioned person_id
select *
From person
where id=99716;

select *
from person
where  id=24556;

--Miranda Priestly and Bryan Pardo
--Jeremy said he was hired by a woman
--in Conclusion Jeremy Bowers was hired by Miranda Priestly to commit the murder.