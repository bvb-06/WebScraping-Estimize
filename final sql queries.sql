create database msa8040;
use  msa8040;
show tables;
Select * from epsdata;
Select * from analystinfodata;
Select * from companydata;

select distinct Company, count(Name) from epsdata group by Company order by count(Name) desc;

SELECT
    E.Ticker,
    E.Company,
    E.Name,
    A.UserID,
    A.AnalystConfidenceScore,
    A.Accuracy_Percentile,
    SUM(A.Points) as Total_points
FROM epsdata E
INNER JOIN analystinfodata A
    ON E.Name = A.Name
WHERE E.Ticker = 'NKE'
GROUP BY E.Ticker, E.Company, E.Name, A.UserID, A.AnalystConfidenceScore, A.Accuracy_Percentile
ORDER BY A.AnalystConfidenceScore DESC, Total_points, A.Accuracy_Percentile;

SELECT
    C.Company,
    C.Industries,
    C.Sectors,
    AVG(C.NumberofAnalysts) as Avg_analysts
FROM companydata C
INNER JOIN epsdata E ON C.Company = E.Company
GROUP BY C.Company, C.Industries, C.Sectors;


SELECT
    E.Company,
    C.Industries,
    C.Sectors,
    AVG(C.NumberofAnalysts) as Avg_analysts
FROM epsdata E
INNER JOIN companydata C ON C.Company = E.Company
WHERE TRIM(C.Industries) = 'Software'
GROUP BY E.Company, C.Industries, C.Sectors;


SELECT
    C.Company,
    COUNT(A.Name) as Analyst_count
FROM companydata C
INNER JOIN analystinfodata A 
WHERE A.AnalystConfidenceScore = (
    SELECT MAX(AI.AnalystConfidenceScore) as max_score
    FROM analystinfodata AI
    WHERE AI.AnalystConfidenceScore > 7
)
GROUP BY C.Company;

SELECT Company, MAX(NumberofFollowers) AS LargestNumberOfFollowers
FROM companydata
GROUP BY Company;

SELECT Company, NumberofFollowers
FROM companydata
where Ticker = 'AAPL'
LIMIT 1;

SELECT
    C.Company,
    COUNT(A.Name) AS AnalystCount
FROM companydata C
INNER JOIN analystinfodata A ON C.Company = A.Company
WHERE A.AnalystConfidenceScore > 7
GROUP BY C.Company
ORDER BY AnalystCount DESC
LIMIT 1;

SELECT
    C.Company,
    COUNT(A.Name) AS AnalystCount
FROM companydata C
INNER JOIN epsdata E ON C.Ticker = E.Ticker
INNER JOIN analystinfodata A ON E.Name = A.UserID
WHERE A.AnalystConfidenceScore > 7
GROUP BY C.Company
ORDER BY AnalystCount DESC
LIMIT 1;

#3
select count(Company) from epsdata
where Company = 'Procter & Gamble Co.';

Select * from epsdata;
Select * from analystinfodata;
Select * from companydata;


select e.Company, count(e.Name) from epsdata as e join analystinfodata as a on e.Name=a.UserID where a.AnalystConfidenceScore>7
group by e.Company 
order by e.Company desc
limit 1;

SELECT
    c.Ticker,
    c.Company,
    count(c.NumberofAnalysts),
    a.AnalystConfidenceScore as MaxAnalystConfidenceScore
FROM companydata c
JOIN epsdata e ON c.Ticker = e.Ticker
JOIN analystinfodata a ON a.UserID = e.Name
GROUP BY c.Ticker, c.Company, c.NumberofAnalysts
having a.AnalystConfidenceScore > 7
ORDER BY c.NumberofAnalysts DESC
LIMIT 1;


SELECT
    c.Ticker,
    c.Company,
    COUNT(c.NumberofAnalysts) AS AnalystCount,
    MAX(a.AnalystConfidenceScore) AS MaxAnalystConfidenceScore
FROM companydata c
JOIN epsdata e ON c.Ticker = e.Ticker
JOIN analystinfodata a ON a.UserID = e.Name
WHERE a.AnalystConfidenceScore > 7
GROUP BY c.Ticker, c.Company
ORDER BY AnalystCount DESC
LIMIT 1;
