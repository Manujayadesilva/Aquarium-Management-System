-- Table for Aquarium
CREATE TABLE Aquarium (
    aquarium_id NUMBER PRIMARY KEY,
    location VARCHAR2(100) NOT NULL,
    capacity NUMBER CHECK (capacity > 0) NOT NULL
);

-- Table for Tank
CREATE TABLE Tank (
    tank_id NUMBER PRIMARY KEY,
    water_type VARCHAR2(10) CHECK (water_type IN ('Fresh', 'Salt')) NOT NULL,
    temperature NUMBER CHECK (temperature BETWEEN 0 AND 40) NOT NULL,
    ph_level NUMBER CHECK (ph_level BETWEEN 0 AND 14) NOT NULL,
    aquarium_id NUMBER,
    CONSTRAINT fk_aquarium FOREIGN KEY (aquarium_id) REFERENCES Aquarium(aquarium_id) ON DELETE CASCADE
);

-- Table for Aquatic Animal
CREATE TABLE Aquatic_Animal (
    animal_id NUMBER PRIMARY KEY,
    species VARCHAR2(50) NOT NULL,
    name VARCHAR2(50),
    age NUMBER CHECK (age >= 0),
    health_status VARCHAR2(20) CHECK (health_status IN ('Healthy', 'Sick', 'Critical')),
    tank_id NUMBER,
    CONSTRAINT fk_tank FOREIGN KEY (tank_id) REFERENCES Tank(tank_id) ON DELETE SET NULL
);

-- Table for Staff
CREATE TABLE Staff (
    staff_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    role VARCHAR2(50) NOT NULL,
    contact_information VARCHAR2(100),
    assigned_tank_id NUMBER,
    CONSTRAINT fk_assigned_tank FOREIGN KEY (assigned_tank_id) REFERENCES Tank(tank_id) ON DELETE SET NULL
);

-- Table for Maintenance Schedule
CREATE TABLE Maintenance_Schedule (
    schedule_id NUMBER PRIMARY KEY,
    task VARCHAR2(50) NOT NULL,
    schedule_date DATE NOT NULL,
    staff_id NUMBER,
    tank_id NUMBER,
    CONSTRAINT fk_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE SET NULL,
    CONSTRAINT fk_schedule_tank FOREIGN KEY (tank_id) REFERENCES Tank(tank_id) ON DELETE CASCADE
);




INSERT INTO Aquarium (aquarium_id, location, capacity) 
VALUES (1, 'Central Aquarium', 100);

INSERT INTO Aquarium (aquarium_id, location, capacity) 
VALUES (2, 'Marine World', 200);

INSERT INTO Aquarium (aquarium_id, location, capacity) 
VALUES (3, 'Tropical Haven', 150);



INSERT INTO Tank (tank_id, water_type, temperature, ph_level, aquarium_id) 
VALUES (1, 'Fresh', 23, 7.0, 1);

INSERT INTO Tank (tank_id, water_type, temperature, ph_level, aquarium_id) 
VALUES (2, 'Fresh', 25, 6.8, 1);

INSERT INTO Tank (tank_id, water_type, temperature, ph_level, aquarium_id) 
VALUES (3, 'Salt', 28, 8.0, 2);

INSERT INTO Tank (tank_id, water_type, temperature, ph_level, aquarium_id) 
VALUES (4, 'Fresh', 26, 7.2, 3);

INSERT INTO Tank (tank_id, water_type, temperature, ph_level, aquarium_id) 
VALUES (5, 'Salt', 27, 8.1, 2);



INSERT INTO Aquatic_Animal (animal_id, species, name, age, health_status, tank_id) 
VALUES (1, 'Goldfish', 'Goldy', 2, 'Healthy', 1);

INSERT INTO Aquatic_Animal (animal_id, species, name, age, health_status, tank_id) 
VALUES (2, 'Carp', 'Swifty', 3, 'Healthy', 2);

INSERT INTO Aquatic_Animal (animal_id, species, name, age, health_status, tank_id) 
VALUES (3, 'Shark', 'Jaws', 5, 'Sick', 3);

INSERT INTO Aquatic_Animal (animal_id, species, name, age, health_status, tank_id) 
VALUES (4, 'Clownfish', 'Nemo', 1, 'Critical', 5);

INSERT INTO Aquatic_Animal (animal_id, species, name, age, health_status, tank_id) 
VALUES (5, 'Betta', 'Alpha', 1, 'Healthy', 4);



INSERT INTO Staff (staff_id, name, role, contact_information, assigned_tank_id) 
VALUES (1, 'Amaya', 'Technician', '07612345678', 1);

INSERT INTO Staff (staff_id, name, role, contact_information, assigned_tank_id) 
VALUES (2, 'Amasha', 'Technician', '07612445678', 2);

INSERT INTO Staff (staff_id, name, role, contact_information, assigned_tank_id) 
VALUES (3, 'Thamodi', 'Cleaner', '07612345178', 3);

INSERT INTO Staff (staff_id, name, role, contact_information, assigned_tank_id) 
VALUES (4, 'Manujaya', 'Feeder', '07612345638', 4);

INSERT INTO Staff (staff_id, name, role, contact_information, assigned_tank_id) 
VALUES (5, 'Enuri', 'Cleaner', '07612342678', 5);



INSERT INTO Maintenance_Schedule (schedule_id, task, schedule_date, staff_id, tank_id) 
VALUES (1, 'Feeding', TO_DATE('2024-09-27', 'YYYY-MM-DD'), 4, 1);

INSERT INTO Maintenance_Schedule (schedule_id, task, schedule_date, staff_id, tank_id) 
VALUES (2, 'Cleaning', TO_DATE('2024-09-29', 'YYYY-MM-DD'), 3, 3);

INSERT INTO Maintenance_Schedule (schedule_id, task, schedule_date, staff_id, tank_id) 
VALUES (3, 'Water Check', TO_DATE('2024-09-30', 'YYYY-MM-DD'), 1, 2);

INSERT INTO Maintenance_Schedule (schedule_id, task, schedule_date, staff_id, tank_id) 
VALUES (4, 'Feeding', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 2, 2);

INSERT INTO Maintenance_Schedule (schedule_id, task, schedule_date, staff_id, tank_id) 
VALUES (5, 'Cleaning', TO_DATE('2024-10-02', 'YYYY-MM-DD'), 5, 5);


SET SERVEROUTPUT ON;
BEGIN
    INSERT INTO Aquatic_Animal (animal_id, species, name, age, health_status, tank_id)
    VALUES (7, 'Clownfish', 'No', 2, 'Healthy', 1);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;
BEGIN
    UPDATE Aquatic_Animal
    SET health_status = 'Sick'
    WHERE animal_id = 5;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;
BEGIN
    DELETE FROM Aquatic_Animal
    WHERE animal_id = 7;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;
BEGIN
    FOR animal IN (SELECT * FROM Aquatic_Animal WHERE tank_id = 1)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Animal: ' || animal.name || ', Species: ' || animal.species);
    END LOOP;
END;
/





--Tank and Animal Count with Additional Filters (Adding AND, LIKE, and CASE)
SET SERVEROUTPUT ON;
BEGIN
    FOR tank_info IN (
        SELECT t.tank_id, 
               COUNT(a.animal_id) AS animal_count,
               CASE 
                 WHEN COUNT(a.animal_id) > 10 THEN 'Over Capacity'
                 ELSE 'Normal'
               END AS capacity_status
        FROM Tank t
        LEFT JOIN Aquatic_Animal a ON t.tank_id = a.tank_id
        WHERE t.water_type = 'Fresh'  
        GROUP BY t.tank_id
        HAVING COUNT(a.animal_id) > 0 
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Tank ID: ' || tank_info.tank_id || ', Animal Count: ' || tank_info.animal_count || ', Status: ' || tank_info.capacity_status);
    END LOOP;
END;
/




-- Fetching Sick/Critical Animals with AND Condition and LIKE for Name Search
set serveroutput on;
BEGIN
    FOR animal IN (
        SELECT name, species, health_status
        FROM Aquatic_Animal
        WHERE health_status IN ('Sick')
        AND species LIKE '%Goldfish%'  
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Animal: ' || animal.name || ', Species: ' || animal.species || ', Health: ' || animal.health_status);
    END LOOP;
END;
/


--Upcoming Maintenance Tasks with AND and CASE for Task Urgency
SET SERVEROUTPUT ON;
BEGIN
    FOR task IN (
        SELECT task, schedule_date, tank_id,
               CASE 
                 WHEN schedule_date = SYSDATE THEN 'Urgent'
                 ELSE 'Scheduled'
               END AS task_status
        FROM Maintenance_Schedule
        WHERE schedule_date BETWEEN SYSDATE AND SYSDATE + 7
        AND task LIKE '%clean%' 
        ORDER BY schedule_date
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Task: ' || task.task || ', Scheduled Date: ' || task.schedule_date || ', Tank ID: ' || task.tank_id || ', Status: ' || task.task_status);
    END LOOP;
END;
/


--Average Tank Temperature with IF/ELSE Logic
SET SERVEROUTPUT ON;
DECLARE
    avg_temp NUMBER;
BEGIN
    FOR temp_report IN (
        SELECT a.aquarium_id, AVG(t.temperature) AS avg_temperature
        FROM Aquarium a
        JOIN Tank t ON a.aquarium_id = t.aquarium_id
        GROUP BY a.aquarium_id
    )
    LOOP
        avg_temp := temp_report.avg_temperature;

        IF avg_temp > 25 THEN
            DBMS_OUTPUT.PUT_LINE('Aquarium ID: ' || temp_report.aquarium_id || ', Average Temperature: ' || avg_temp || ' (High)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Aquarium ID: ' || temp_report.aquarium_id || ', Average Temperature: ' || avg_temp || ' (Normal)');
        END IF;
    END LOOP;
END;
/



--Staff Assigned to Multiple Tanks with AND Condition and Enhanced HAVING Clause
SET SERVEROUTPUT ON;
BEGIN
    FOR staff_report IN (
        SELECT s.staff_id, s.name, COUNT(t.tank_id) AS tank_count
        FROM Staff s
        JOIN Tank t ON s.assigned_tank_id = t.tank_id
        WHERE s.role = 'Technician'
        GROUP BY s.staff_id, s.name
        HAVING COUNT(t.tank_id) > 1 
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Staff ID: ' || staff_report.staff_id || ', Name: ' || staff_report.name || ', Tank Count: ' || staff_report.tank_count);
    END LOOP;
END;
/



select * from AQUARIUM;
select * from AQUATIC_ANIMAL;
select * from MAINTENANCE_SCHEDULE;
select * from STAFF;
select * from TANK;


--counting animal in a specific water type
SET SERVEROUTPUT ON;
BEGIN
    FOR tank_info IN (
        SELECT t.tank_id, 
               t.water_type,
               COUNT(a.animal_id) AS animal_count
        FROM Tank t
        LEFT JOIN Aquatic_Animal a ON t.tank_id = a.tank_id
        WHERE t.water_type IN ('Fresh', 'Salt')
        GROUP BY t.tank_id, t.water_type
        HAVING COUNT(a.animal_id) > 0 
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Tank ID: ' || tank_info.tank_id || ', Water Type: ' || tank_info.water_type || ', Animal Count: ' || tank_info.animal_count);
    END LOOP;
END;
/

--display sick animals with name
SET SERVEROUTPUT ON;
BEGIN
    FOR animal IN (
        SELECT name, species, health_status
        FROM Aquatic_Animal
        WHERE health_status = 'Sick' -- Filter sick animals
        AND species LIKE '%Goldfish%' -- Only search animals with names containing 'y'
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Animal Name: ' || animal.name || ', Species: ' || animal.species || ', Health: ' || animal.health_status);
    END LOOP;
END;
/


--upcoming maintain task
SET SERVEROUTPUT ON;
BEGIN
    FOR task IN (
        SELECT task, schedule_date, tank_id
        FROM Maintenance_Schedule
        WHERE schedule_date BETWEEN SYSDATE AND SYSDATE + 7 
        ORDER BY schedule_date 
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Task: ' || task.task || ', Scheduled Date: ' || task.schedule_date || ', Tank ID: ' || task.tank_id);
    END LOOP;
END;
/


--calculate tank temperarture
SET SERVEROUTPUT ON;
DECLARE
    avg_temp NUMBER;
BEGIN
    FOR temp_report IN (
        SELECT a.aquarium_id, AVG(t.temperature) AS avg_temperature
        FROM Aquarium a
        JOIN Tank t ON a.aquarium_id = t.aquarium_id
        GROUP BY a.aquarium_id
    )
    LOOP
        avg_temp := temp_report.avg_temperature;

        IF avg_temp > 25 THEN
            DBMS_OUTPUT.PUT_LINE('Aquarium ID: ' || temp_report.aquarium_id || ', Average Temperature: ' || avg_temp || ' (High)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Aquarium ID: ' || temp_report.aquarium_id || ', Average Temperature: ' || avg_temp || ' (Normal)');
        END IF;
    END LOOP;
END;
/


--staff assign to tanks
SET SERVEROUTPUT ON;
BEGIN
    FOR staff_report IN (
        SELECT s.staff_id, s.name, COUNT(t.tank_id) AS tank_count
        FROM Staff s
        JOIN Tank t ON s.assigned_tank_id = t.tank_id
        WHERE s.role = 'Technician' 
        GROUP BY s.staff_id, s.name
       
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Staff ID: ' || staff_report.staff_id || ', Name: ' || staff_report.name || ', Assigned Tanks: ' || staff_report.tank_count);
    END LOOP;
END;
/







