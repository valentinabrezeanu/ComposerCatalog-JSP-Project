# ComposerCatalog-JSP-Project
Platformă web în JSP pentru gestiunea compozitorilor și operelor muzicale. Implementează operații CRUD complete pe o bază de date relațională, oferind o interfață fluidă pentru administrarea artiștilor, compozițiilor și a colaborărilor profesionale între aceștia.
Tehnologii utilizate

Pentru proiectarea și administrarea bazei de date a fost utilizat MySQL Workbench 8.0, o soluție consacrată în domeniul dezvoltării software, recunoscută pentru fiabilitatea sa în gestionarea bazelor de date relaționale. Alegerea acestei tehnologii a fost determinată de necesitatea modelării corecte a relațiilor de tip many-to-many dintre entitățile „Compositions” și „Composers”, garantând integritatea și coerența datelor prin intermediul unui tabel de legătură dedicat colaborărilor.
La nivelul interfeței a fost folosit JSP (Java Server Pages), o tehnologie care permite îmbinarea codului Java cu structura paginilor web. Astfel, aplicația poate genera conținut dinamic, în funcție de cererile utilizatorilor. La accesarea catalogului, serverul procesează logica necesară, interoghează baza de date MySQL și furnizează utilizatorului o pagină HTML completă, actualizată în timp real cu informațiile existente în sistem.
Implementare

Baza de date a fost realizată cu ajutorul MySQL Workbench, fiind alcătuită din două tabele principale: Compositions și Composers. Pentru a realiza o asociere de tip M:N (Many-to-Many) între aceste două entități — având în vedere că o compoziție poate fi rezultatul muncii mai multor autori, iar un compozitor poate contribui la multiple opere — a fost creată o tabelă intermediară numită Collaborations.
Structura coloanelor tabelelor:
1.	Tabela Compositions = Stochează informațiile despre operele muzicale
•	idcomposition (tip INT, cheie primară, Not Null, Auto-Increment)
•	Title (tip VARCHAR(150), Not Null)
•	Release_date (tip DATE, Not Null)
•	Duration (tip INT, Not Null)
•	Genre (tip VARCHAR(150), Not Null)

2.	Tabela Composers = Stochează datele de identificare ale autorilor
•	idcomposer (tip INT, cheie primară, Not Null, Auto-Increment)
•	Last_name (tip VARCHAR(150), Not Null)
•	First_name (tip VARCHAR(150), Not Null)
•	Age (tip INT, Not Null)
•	Nr_works (tip INT, Not Null)

3.	Tabela Collaborations = Tabelă de legătură
•	idcollaboration (tip INT, cheie primară, Not Null, Auto-Increment)
•	idcomposition (tip INT, cheie străină, Not Null)
•	idcomposer (tip INT, cheie străină, Not Null)
•	Role_composer (tip VARCHAR(150), Not Null)
•	Start_date (tip DATE, Not Null)
Datorită asocierii de tip M:N, coloanele idcomposition și idcomposer din tabela Collaborations au fost setate ca chei străine (Foreign Keys), făcând referire la tabelele părinte corespunzătoare. Acestea au fost configurate cu proprietățile ON DELETE CASCADE și ON UPDATE CASCADE pentru a asigura integritatea datelor (ștergerea sau modificarea unui compozitor se reflectă automat în înregistrările colaborărilor sale).
