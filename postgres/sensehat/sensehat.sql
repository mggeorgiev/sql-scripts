-- drop table public.datapoints;

CREATE TABLE IF NOT EXISTS public.datapoints (
    id serial PRIMARY KEY,
    "time" TIMESTAMP,
    temperaturevalue real,
    pressurevalue real,
    humidityvalue real, 
    temperature_calibrated real,
    running_average real
    );