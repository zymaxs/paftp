@echo off
C:
cd C:\Program Files\MySQL\MySQL Server 5.6\bin
@set db=paftp
@set userName=root
@set password=Paic#234
@set sqlpath=C:\GitHub\paftp\PAFTestPlatform\sql\insertbusiness.sql
mysql -f -u %userName% --password=%password% %db% < %sqlpath% --default-character-set=utf8
@echo "Finish to re-create the database and tables!"
pause
