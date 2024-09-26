CREATE TABLE 
    datecustom AS
SELECT 
    date_day::TIMESTAMP                          AS pk_date,
    CAST(TO_CHAR(date_day, '%Y%m%d') AS DECIMAL) AS datekey,
    TO_CHAR(date_day, '%A, %B %d, %Y')           AS date_name,
    CAST(EXTRACT(YEAR FROM date_day) AS STRING)  AS YEAR,
    concat('Calendar ',TO_CHAR(date_day, '%Y'))  AS year_name,
    IFF(EXTRACT(QUARTER FROM date_day) < 3, DATE_TRUNC('year', date_day), DATEADD('quarter', 2, 
    DATE_TRUNC('year', date_day))) AS half_year,
    IFF(EXTRACT(QUARTER FROM date_day) < 3, concat('Semester 1, ',TO_CHAR(date_day, '%Y')), concat 
    ('Semester 2, ', TO_CHAR(date_day, '%Y')))                                    AS half_year_name,
    DATE_TRUNC('quarter', date_day)                                                      AS quarter,
    concat('Quarter ', EXTRACT(QUARTER FROM date_day), ', ', EXTRACT(YEAR FROM date_day)) AS 
                                     quarter_name,
    DATE_TRUNC('month', date_day)                                           AS MONTH,
    TO_CHAR(date_day, '%B %Y')                                              AS month_name,
    DATE_TRUNC('week', date_day)                                            AS week,
    concat('Week ', EXTRACT(WEEK FROM date_day), TO_CHAR(date_day, ', %Y')) AS week_name,
    EXTRACT(DAYOFYEAR FROM date_day)                                        AS day_of_year,
    concat('Day ', EXTRACT(DAYOFYEAR FROM date_day))                        AS day_of_year_name,
    EXTRACT(DAYOFWEEK FROM date_day)                                        AS day_of_week,
    DAYNAME(date_day)                                                       AS day_of_week_name,
    EXTRACT(WEEK FROM date_day)                                             AS week_of_year,
    concat('Week ', EXTRACT(WEEK FROM date_day))                            AS week_of_year_name,
    EXTRACT(MONTH FROM date_day)                                            AS month_of_year,
    MONTHNAME(date_day)                                                     AS month_of_year_name,
    EXTRACT(QUARTER FROM date_day)                                          AS quarter_of_year,
    concat('Quarter ', EXTRACT(QUARTER FROM date_day))                      AS quarter_of_year_name
FROM 
    (   SELECT 
            DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY 1) - 1, '1990-01-01') date_day
        FROM 
            TABLE(GENERATOR(ROWCOUNT => 3650)) );