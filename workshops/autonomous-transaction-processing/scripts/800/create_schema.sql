--------------------------------------------------------
--  File created - Monday-August-10-2015   
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Sequence COMMENTS_COMMENT_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "COMMENTS_COMMENT_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ITEMS_ITEM_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ITEMS_ITEM_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 81 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence OFFERS_OFFER_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OFFERS_OFFER_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 141 CACHE 20 NOORDER  NOCYCLE ;

--------------------------------------------------------
--  DDL for Sequence USERS_USER_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "USERS_USER_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table COMMENTS
--------------------------------------------------------

  CREATE TABLE "COMMENTS" 
   (  "COMMENT_ID" NUMBER(10,0), 
  "ITEM_ID" NUMBER(10,0), 
  "COMMENT_BY" NUMBER(10,0), 
  "COMMENT_CREATE_DATE" DATE DEFAULT sysdate, 
  "COMMENT_TEXT" VARCHAR2(500)
   ) ;
--------------------------------------------------------
--  DDL for Table ITEMS
--------------------------------------------------------

  CREATE TABLE "ITEMS" 
   (  "ITEM_ID" NUMBER(10,0), 
  "ITEM_TITLE" VARCHAR2(100), 
  "ITEM_DESC" VARCHAR2(2000), 
  "ITEM_POST_DATE" DATE DEFAULT sysdate, 
  "ITEM_POSTED_BY" NUMBER(10,0), 
  "ITEM_BOUGHT_BY" NUMBER(10,0), 
  "ITEM_PRICE" NUMBER(4,0), 
  "ITEM_STATUS" VARCHAR2(25)
   ) ;
--------------------------------------------------------
--  DDL for Table OFFERS
--------------------------------------------------------

  CREATE TABLE "OFFERS" 
   (  "OFFER_ID" NUMBER(10,0), 
  "ITEM_ID" NUMBER(10,0), 
  "OFFER_BY" NUMBER(10,0), 
  "OFFER_AMOUNT" NUMBER(10,0), 
  "OFFER_CREATE_DATE" DATE DEFAULT SYSDATE, 
  "OFFER_STATUS" VARCHAR2(15)
   ) ;
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "USERS" 
   (  "USER_ID" NUMBER(10,0), 
  "USER_NAME" VARCHAR2(50), 
  "USER_PASSWORD" VARCHAR2(50), 
  "USER_EMAIL" VARCHAR2(50), 
  "USER_GRAVATAR" VARCHAR2(500)
   ) ;
REM INSERTING into COMMENTS
SET DEFINE OFF;
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (6,4,4,to_date('06-JUL-15','DD-MON-RR'),'Im putting an offer. Can you meet me at the apple store this evening?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (7,4,4,to_date('06-JUL-15','DD-MON-RR'),'Im putting an offer. Can you meet me at the apple store this evening?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (12,5,4,to_date('07-JUL-15','DD-MON-RR'),'Does this work with any bike?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (14,5,4,to_date('08-JUL-15','DD-MON-RR'),'Does this work with all bikes?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (15,5,12,to_date('08-JUL-15','DD-MON-RR'),'Hi, I just put an offer for this item. Where can I see it?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (16,8,6,to_date('08-JUL-15','DD-MON-RR'),'this item is no longer available');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (1,4,4,to_date('09-JUL-15','DD-MON-RR'),'hey we met yesterday but the phone''s screen was cracked. will you cover the replacement? if not drop the price by $100 and i''ll consider it');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (53,13,4,to_date('13-JUL-15','DD-MON-RR'),'Can you describe your guitar? is it electric?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (9,10,10,to_date('06-JUL-15','DD-MON-RR'),'when I come see it? I live in san ramon');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (10,10,10,to_date('06-JUL-15','DD-MON-RR'),'we need to meet somewhere nearby since I don''t have a car yet. Let me know if you can meet me in the DVHS parking lot');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (13,11,1,to_date('08-JUL-15','DD-MON-RR'),'Sunny just make an offer');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (21,21,1,to_date('12-JUL-15','DD-MON-RR'),'I am interested in this table');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (43,7,7,to_date('13-JUL-15','DD-MON-RR'),'Hi James, can you tell me old is this item?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (50,41,4,to_date('13-JUL-15','DD-MON-RR'),'HI, I am making an offer for this item. Hope it is in good condition. Offer subject to condition of item');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (62,22,21,to_date('21-JUL-15','DD-MON-RR'),'How much memory?');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (81,22,61,to_date('30-JUL-15','DD-MON-RR'),'Hey I just made an offer');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (101,61,1,to_date('04-AUG-15','DD-MON-RR'),'Hey Dave...nice bike. making as offer');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (8,4,1,to_date('06-JUL-15','DD-MON-RR'),'Hi, I am seriously interested in your iphone. Putting a full price offer!');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (11,10,2,to_date('06-JUL-15','DD-MON-RR'),'I love this bike. Just submitted an offer');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (22,3,7,to_date('12-JUL-15','DD-MON-RR'),'Just put an offer. Pls email me yourlocation');
Insert into COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (61,41,4,to_date('20-JUL-15','DD-MON-RR'),'Hey Im putting an offer for this. let me know');
REM INSERTING into ITEMS
SET DEFINE OFF;
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (8,'Italian Antique Hand-Painted Porcelain Trinket Boxes','Antique hand-painted porcelain trinket boxes with hinged lids, purchased in 1985 at the Clignancourt Flea Market in Paris, mint condition, $75 each 
2 inch square with gilt floral design
1.75 inch diameter says FORCE and SAGESSE

Salmon Size 34 SNS Profeil cross country ski boots

Fit Karbu 130cm cross country skis

70 cm cross country skis',to_date('09-JUL-15','DD-MON-RR'),6,null,70,'cancelled');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (2,'Pool tables, 1" Slate, Real Wood, NO MDF','Key Features:
Table Size: 7'' and 8'' regulation sizes
Frame: 100% Real Wood (NO Plywood, MDF or OSB)
Legs: 100% Real Wood (NO Plywood, MDF or OSB)
Rails: 100% Real Wood (NO Plywood, MDF or OSB)
Side 100% Real Wood (NO Plywood, MDF or OSB)
Slate: 1" Slate, Diamond Honed, Matched (Solid Wood Backed) 
Pocket Size: Meets BCA Specifications
Pockets: 100% Leather (NO SYNTHETIC)
Rail Sights: Mother Pearl
Cushions: 100% Gum Cushions K66 (No Fillers)
Felt: 21oz Felt (Upgrade to Championship)
Table Guarantee: 5 year Manufacture Warranty (See web site for details)
Installation Guarantee: No payment due until you are 100% happy with the table.',to_date('09-JUL-15','DD-MON-RR'),4,null,1450,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (3,'2 pack tennis rackets','got some tennis rackets but they were not at a professional standard. still at great quality and awesome for anyone who wants to start playing tennis',to_date('09-JUL-15','DD-MON-RR'),4,null,50,'sold');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (21,'Pool table','My pool table for sale',to_date('12-JUL-15','DD-MON-RR'),4,null,100,'sold');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (22,'Used macbook','MBP 15 in retina 2012 model in great condition',to_date('12-JUL-15','DD-MON-RR'),7,null,1650,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (61,'Bicycle','My Schwinn Bike is ready to go',to_date('04-AUG-15','DD-MON-RR'),81,null,100,'sold');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (7,'White Alabaster Egg (mint condition)','White alabaster egg, approximately 3 inches long, mint condition, $5

Salmon Size 34 SNS Profeil cross country ski boots

Fit Karbu 130cm cross country skis

70 cm cross country skis',to_date('09-JUL-15','DD-MON-RR'),5,null,5,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (9,'Garden Tool Organizer / Bicycle Storage Rack - 36"','Are you tired of tripping over a bunch of loose garden tools in your garage? Are your brooms, rakes, shovels, bicycles etc. always in a big cluttered mess? As a machine shop owner, I make a really nice, possibly the best, Garage Organizer - Garden Tool - Bicycle Storage Rack, where you can neatly hang these items.

**** My Design:

* Is very strong and holds many clumsy things, like garden tools and bicycles, in a tight place. 
* Is a very simple design, adjustable to fit many different items. 
* Doesn''t take up any valuable floor space.
* Bicycles can be hung parallel or perpendicular to the wall.
* Includes many large Straight Hooks and two styles of Rubber Padded Bicycle Hook.
* Long, tempered, Torx wood screws that will line up with every wall stud, with or without sheetrock.
* Made from solid aluminum bar stock, threaded steel rod, nuts, washers, high quality tempered steel wood screws and machined aluminum screw adapters. 
* Includes a magnet to find wall studs, a Torx screw bit, eye screws for the ends of your wooden tool 
handles, and easy instructions.

**** Here''s what you will receive: 

36" Tool Rack Kit - $89.00
* One 36" aluminum beam with 36 threaded holes 
* Six 12" hooks with nuts and washers 
* Four 8" hooks with nuts and washers
* Two styles of Rubber Padded Bicycle Hook with nuts and washers 
* Four 2 1/2" wood screws with adapters
* One Torx bit to fit the wood screws
* One stud finder magnet
* Six eye screws
* Instructions

$89.00 is a cash price for Santa Clara pick up. Reply with your phone number. 
I have this and 2 other larger sizes, extra hooks, more pictures, and better description on eBay.
Do an eBay search for item # 161667038684

Salmon Size 34 SNS Profeil cross country ski boots

Fit Karbu 130cm cross country skis

70 cm cross country skis',to_date('09-JUL-15','DD-MON-RR'),7,null,89,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (10,'***2004 Yamaha R6 Motorcycle*** clean title***','For sale a clean 2004 Yamaha R6 factory blue with 27k commuting miles. Clean title in hand and current registration. Excellent condition. A few minor mods liked front signals, rear eliminator kit, integrated taillight, a rear solo seat cowl and frame sliders. All service up to date. Nothing is needed.


price: $3600 firm 
email if interested and I will call you back asap. thx.

Salmon Size 34 SNS Profeil cross country ski boots

Fit Karbu 130cm cross country skis

70 cm cross country skis',to_date('09-JUL-15','DD-MON-RR'),8,null,3600,'sold');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (12,'VOX Standard 24 Guitar- Made in Japan','This is a Vox Standard 24 3503, made some time between 1979 and 82. It works great and holds it''s tuning, but it shows its wear. Consistent with it''s age, this guitar has lots of dings, impressions, edge chipping, scratches and swirling (Pictures provided). 
A workhorse.
I love it, but I am changing my sound. 
I have owned this VOX for about five years and it has been my personal electric guitar at the studio, a non smoker environment.

The serial number is 2010313. These were manufactured in Japan at the Matsumoku factory during the golden era of Japanese guitars. 

The frets are in good condition, showing light wear. 

The Dimarzio Super Distortion Humbuckers make this machine very powerful, crunchy and aggressive in a very "1970''s" Classic or Glam rock kind of way. 

Additional specs:
Standard 24 Black - 3503
Black polyester finish
24 3/4 inch scale length
Fixed neck construction; twinDiMarzio
Super Distortion Humbuckers
Body and neck from selected Nato timber
Individual smooth machine heads
Volume and tone controls for each pickup
Three way pickup selector

Included is a case that fits the Vox perfectly. It looks used on the outside, but it is a tank. The locks show some rust, but they work perfectly. I mean, these lock precisely AND the case comes with it''s original key. The case lid opens to just past 90 degrees and stays there. The lines are straight and solid. I originally wanted to keep it, but it fits the Vox perfectly and matches it''s age and quality of build so I am selling them together. 
Local pick up only. Price is FIRM. Cash only and you must bring your own amp to test it so you know what it sounds like though something you already know. Right?
Salmon Size 34 SNS Profeil cross country ski boots

Fit Karbu 130cm cross country skis

70 cm cross country skis',to_date('09-JUL-15','DD-MON-RR'),10,null,500,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (5,'Kinetic by Kurt Road Machine Indoor Bicycle Trainer','Kinetic by Kurt Road Machine Indoor Bicycle Trainer and front wheel stand.

Used 2 times for about 30 mins each time. 

Retail price is $379.

I am also selling the pictured Giant OCRc2 if interested.',to_date('09-JUL-15','DD-MON-RR'),1,null,200,'sold');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (6,'Cross Country Ski Boots and Skis','Kinetic by Kurt Road Machine Indoor Bicycle Trainer and rear wheel stand.

Used 2 times for about 30 mins each time. 

Retail price is $379.

Salmon Size 34 SNS Profeil cross country ski boots

Fit Karbu 130cm cross country skis

70 cm cross country skis',to_date('09-JUL-15','DD-MON-RR'),4,null,20,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (11,'1940''s Noritake Japan China Set','1940''s Noritake Japan China Set
Lynns of Alameda
2807 Encinal Ave.
Alameda

Salmon Size 34 SNS Profeil cross country ski boots

Fit Karbu 130cm cross country skis

70 cm cross country skis',to_date('09-JUL-15','DD-MON-RR'),9,null,150,'sold');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (41,'Samsung galaxy s6 active','I''m trying to sell or trade my galaxy s5 active, I would trade for a video game system or I would just sell it straight out. Serious inquiries only.',to_date('13-JUL-15','DD-MON-RR'),12,null,255,'sold');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (4,'unboxed iphone 6','Recd it as a birthday gift from my uncle but I already have a phone so don''t need this. Unboxed with recpt',to_date('09-JUL-15','DD-MON-RR'),3,null,600,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (13,'Guitar','My used guitar',to_date('09-JUL-15','DD-MON-RR'),11,null,100,'available');
Insert into ITEMS (ITEM_ID,ITEM_TITLE,ITEM_DESC,ITEM_POST_DATE,ITEM_POSTED_BY,ITEM_BOUGHT_BY,ITEM_PRICE,ITEM_STATUS) values (1,'2015 Star 36v golf cart...barely used','Features include:
Street legal light kit which includes- head and tail lights, turn signals, brake lights, horn, and hazards
Tinted folding windshield
Folding side mirrors
10??? polished aluminum wheels
Low / high speed switch (runs up to 20 mph in high)
Battery state of charge meter
Side panels
Back seat that folds to diamond plate flat bed
Rear safety grab bar',to_date('09-JUL-15','DD-MON-RR'),2,null,5650,'available');
REM INSERTING into OFFERS
SET DEFINE OFF;
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (3,10,10,3000,null,null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (7,12,4,200,null,null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (10,5,12,150,null,'accepted');
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (11,13,12,80,null,null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (12,7,4,76,to_date('09-JUL-15','DD-MON-RR'),null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (21,21,1,80,to_date('12-JUL-15','DD-MON-RR'),'accepted');
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (22,3,7,40,to_date('12-JUL-15','DD-MON-RR'),null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (23,3,7,40,to_date('12-JUL-15','DD-MON-RR'),'accepted');
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (81,22,42,1500,to_date('27-JUL-15','DD-MON-RR'),null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (6,11,4,100,null,null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (4,10,4,3200,null,null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (41,41,4,255,to_date('13-JUL-15','DD-MON-RR'),'accepted');
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (101,22,61,1500,to_date('30-JUL-15','DD-MON-RR'),null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (121,61,1,90,to_date('04-AUG-15','DD-MON-RR'),'accepted');
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (2,4,4,550,null,null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (5,10,2,3800,null,'accepted');
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (8,11,1,125,null,'accepted');
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (9,13,9,90,null,null);
Insert into OFFERS (OFFER_ID,ITEM_ID,OFFER_BY,OFFER_AMOUNT,OFFER_CREATE_DATE,OFFER_STATUS) values (61,22,4,1500,to_date('20-JUL-15','DD-MON-RR'),null);
REM INSERTING into USERS
SET DEFINE OFF;
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (1,'Sunny Leone','ed49aa872a3651803b63153bd00b6e81ce90ceba','ssunny22@gmail.com','https://www.gravatar.com/avatar/f2adf4eb7c402614b43ec15042fcbe49.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (6,'Paul','4d42b635046885de21680306d550b07ae19ea970','pp@pp.pp','https://www.gravatar.com/avatar/0f4b2c92f1b04f9083caf68dbbc4cbe9.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (11,'sweettiger21','f64de72f5c1bf254aad7e4bb6d4cb538114d043a','ant@aa.aa','https://www.gravatar.com/avatar/5e93f7e9a7d0eb976722076e5a34ebee.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (12,'Jeremy','d93bab8ddc17101414e4778afd4f31f87ce0ba75','jj@jj.jj','https://www.gravatar.com/avatar/64b5cefbdbbbb10b091774a15368db2d.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (41,'Mike Morris','cbf3519f5424d37eeb32ddd3b6bf86b7105987f9','mm@mm.mm','https://www.gravatar.com/avatar/479ea7b27c83919d61899feed1ff0337.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (42,'Karim Khan','ebd138f835b5f4602c9ce2122ffc28d40ed237ac','kk@kk.kk','https://www.gravatar.com/avatar/c116deb8745d67dbf84c621bd195751e.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (81,'Dave Mierzwik','78cfcece9bc69dc20e6ae2ac6ece1e867fdd309c','dm@oracle.com','https://www.gravatar.com/avatar/b7636af5fbc1f3de6a60600c70156907.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (4,'Ashish','f64de72f5c1bf254aad7e4bb6d4cb538114d043a','aa@aa.aa','https://www.gravatar.com/avatar/1cb1c39857f5eef49897f849251861a9.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (5,'James','d93bab8ddc17101414e4778afd4f31f87ce0ba75','jj@jj.jj','https://www.gravatar.com/avatar/64b5cefbdbbbb10b091774a15368db2d.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (9,'Takiyu','9c121510b8b21f87b7d2d7376b56bdaaa64f1cae','tt@tt.tt','https://www.gravatar.com/avatar/18829e0fbe77369f07afb60688aae1d0.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (10,'umesh','adcc75ae6bfa8eabe0be261a7806a838732a219b','uu@uu.uu','https://www.gravatar.com/avatar/6a176042a73df72b4fe504dec322dd52.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (7,'Angel','1fb78717287b33d02ad7ea13508d5b5444fa913a','ll@ll.ll','https://www.gravatar.com/avatar/9e21e946f4d5e27400d1e54a0d8d9285.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (8,'barry','399a4c3c0928187fd116943239ecb5f3aa6171dd','bb@bb.bb','https://www.gravatar.com/avatar/2d880fb7b80033f441dc142e111326d2.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (43,'Michelle','cbf3519f5424d37eeb32ddd3b6bf86b7105987f9','mm@mm.mm','https://www.gravatar.com/avatar/479ea7b27c83919d61899feed1ff0337.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (2,'Samuel Jackson','ed49aa872a3651803b63153bd00b6e81ce90ceba','sammy22@sam.com','https://www.gravatar.com/avatar/c705cc9a8de9f669db8afb3bb825d70a.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (3,'Jay Leno','5f2c0471f183562b2dd2c685dceb8de3911daaa6','jlenno1234@gmail.com','https://www.gravatar.com/avatar/8797f39d02e570e5ebbb04f74d8c13f2.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (21,'cj','ed480e57ec4345af0f4acc616f4f75deaeba322f','cj@cj.cj','https://www.gravatar.com/avatar/8447dfc03853edb26a5931c41586b0b2.jpg?d=identicon');
Insert into USERS (USER_ID,USER_NAME,USER_PASSWORD,USER_EMAIL,USER_GRAVATAR) values (61,'George','a91b610d57b17b8028951455b92a8758caf2920a','gn@gn.gn','https://www.gravatar.com/avatar/eb2aff0ba39f50ff4e8756c8ec6b9e29.jpg?d=identicon');
--------------------------------------------------------
--  Constraints for Table COMMENTS
--------------------------------------------------------

  ALTER TABLE "COMMENTS" MODIFY ("COMMENT_TEXT" NOT NULL ENABLE);
  ALTER TABLE "COMMENTS" MODIFY ("COMMENT_CREATE_DATE" NOT NULL ENABLE);
  ALTER TABLE "COMMENTS" MODIFY ("COMMENT_BY" NOT NULL ENABLE);
  ALTER TABLE "COMMENTS" MODIFY ("ITEM_ID" NOT NULL ENABLE);
  ALTER TABLE "COMMENTS" MODIFY ("COMMENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ITEMS
--------------------------------------------------------

  ALTER TABLE "ITEMS" MODIFY ("ITEM_POST_DATE" NOT NULL ENABLE);
  ALTER TABLE "ITEMS" MODIFY ("ITEM_PRICE" NOT NULL ENABLE);
  ALTER TABLE "ITEMS" MODIFY ("ITEM_DESC" NOT NULL ENABLE);
  ALTER TABLE "ITEMS" MODIFY ("ITEM_TITLE" NOT NULL ENABLE);
  ALTER TABLE "ITEMS" MODIFY ("ITEM_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OFFERS
--------------------------------------------------------

  ALTER TABLE "OFFERS" MODIFY ("OFFER_AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "OFFERS" MODIFY ("OFFER_BY" NOT NULL ENABLE);
  ALTER TABLE "OFFERS" MODIFY ("ITEM_ID" NOT NULL ENABLE);
  ALTER TABLE "OFFERS" MODIFY ("OFFER_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table USERS
--------------------------------------------------------

  ALTER TABLE "USERS" MODIFY ("USER_EMAIL" NOT NULL ENABLE);
  ALTER TABLE "USERS" MODIFY ("USER_NAME" NOT NULL ENABLE);
  ALTER TABLE "USERS" MODIFY ("USER_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  DDL for Trigger COMMENTS_COMMENT_ID_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "COMMENTS_COMMENT_ID_TRIGGER" 
   before insert on comments
   for each row
begin
   if :new.comment_id is null
   then
      :new.comment_id := comments_comment_id_seq.nextval;
   end if;
end COMMENTS_COMMENT_ID_TRIGGER;
/
ALTER TRIGGER "COMMENTS_COMMENT_ID_TRIGGER" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ITEMS_ITEM_ID_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ITEMS_ITEM_ID_TRIGGER" 
   before insert on ITEMS
   for each row
begin
   if :new.ITEM_ID is null
   then
      :new.ITEM_ID := ITEMS_ITEM_ID_seq.nextval;
   end if;
end ITEMS_ITEM_ID_TRIGGER;
/
ALTER TRIGGER "ITEMS_ITEM_ID_TRIGGER" ENABLE;
--------------------------------------------------------
--  DDL for Trigger OFFERS_OFFER_ID_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "OFFERS_OFFER_ID_TRIGGER" 
   before insert on OFFERS
   for each row
begin
   if :new.OFFER_ID is null
   then
      :new.OFFER_ID := OFFERS_OFFER_ID_seq.nextval;
   end if;
end OFFERS_OFFER_ID_TRIGGER;
/
ALTER TRIGGER "OFFERS_OFFER_ID_TRIGGER" ENABLE;
--------------------------------------------------------
--  DDL for Trigger USERS_USER_ID_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "USERS_USER_ID_TRIGGER" 
   before insert on users
   for each row
begin
   if :new.user_id is null
   then
      :new.user_id := users_user_id_seq.nextval;
   end if;
end users_user_id_trigger;
/
ALTER TRIGGER "USERS_USER_ID_TRIGGER" ENABLE;
