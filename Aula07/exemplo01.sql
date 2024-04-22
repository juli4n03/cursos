CREATE TABLE cities (
    name VARCHAR,
    lat  DECIMAL,
    lon  DECIMAL
);

/* DROP TABLE ⟨tablename⟩; */

CREATE TABLE weather (
    city    VARCHAR,
    temp_lo INTEGER, -- minimum temperature on a day
    temp_hi INTEGER, -- maximum temperature on a day
    prcp    REAL,
    date    DATE
);

INSERT INTO weather
VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');

INSERT INTO cities
VALUES ('San Francisco', -194.0, 53.0);

INSERT INTO cities
VALUES ('São Paulo', -194.0, 53.0);

INSERT INTO weather (date, city, temp_hi, temp_lo)
VALUES ('1994-11-29', 'San Francisco', 60, 33);

SELECT *
FROM weather;

SELECT city, temp_lo, temp_hi, prcp, date
FROM weather;

SELECT city, (temp_hi + temp_lo) / 2 AS temp_avg, date
FROM weather;

SELECT *
FROM weather
WHERE city = 'San Francisco' AND prcp > 0.0;

SELECT *
FROM weather
ORDER BY city;

SELECT *
FROM weather
ORDER BY city, temp_lo;

SELECT DISTINCT city
FROM weather;

SELECT DISTINCT city
FROM weather
ORDER BY city;

SELECT *
FROM weather, cities
WHERE city = name;

SELECT city, temp_lo, temp_hi, prcp, date, lon, lat
FROM weather, cities
WHERE city = name;

SELECT weather.city, weather.temp_lo, weather.temp_hi,
       weather.prcp, weather.date, cities.lon, cities.lat
FROM weather, cities
WHERE cities.name = weather.city;

SELECT *
FROM weather
INNER JOIN cities ON weather.city = cities.name;

SELECT *
FROM weather
LEFT OUTER JOIN cities ON weather.city = cities.name;

SELECT max(temp_lo)
FROM weather;

SELECT city
FROM weather
WHERE temp_lo = max(temp_lo);     -- WRONG

SELECT city
FROM weather
WHERE temp_lo = (SELECT max(temp_lo) FROM weather);


WITH max_cte as (
	SELECT max(temp_lo) as max_temp FROM weather
)
SELECT
	city
FROM weather A 
INNER JOIN max_cte B 
	ON A.temp_lo = B.max_temp;
	
SELECT city, max(temp_lo)
FROM weather
GROUP BY city;

SELECT city, max(temp_lo)
FROM weather
GROUP BY city
HAVING max(temp_lo) < 40;

SELECT city, max(temp_lo)
FROM weather
WHERE city LIKE 'S%'            -- (1)
GROUP BY city
HAVING max(temp_lo) < 40;

UPDATE weather
SET temp_hi = temp_hi - 2,  temp_lo = temp_lo - 2
WHERE date > '1994-11-28';

SELECT *
FROM weather;

DELETE FROM weather
WHERE city = 'Hayward';

SELECT *
FROM weather;


SELECT row_number() OVER (ORDER BY name), name FROM cities c ;

SELECT temp_hi - lag(temp_hi) OVER (ORDER BY city) as var_temp, city FROM weather w ;

