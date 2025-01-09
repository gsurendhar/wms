-- moving DATA RECOVERY to Staion Management Module

select * from module where module_id=4

select * from module_menu where module_id=4

select * from module_menu where module_id=3

update module_menu set module_id=3,menu_id=3 where module_id=4 and menu_id=1

delete from role_privilages where module_id=4
delete from module where module_id=4



-- removing Group Management 

select * from module where module_name='Group Management'

delete from role_privilages where module_id=(select module_id from module where module_name='Group Management')
delete from module where module_id=(select module_id from module where module_name='Group Management')


-- adding a active flag to the menu
select * from module_menu
alter table module_menu add active char(1) default 'Y'

update module_menu set active='N' where menu_name='Threshold Values'

