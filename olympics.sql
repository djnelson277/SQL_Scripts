-- Olympic dataset downloaded from : https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbE9WRjhFd2dxbGhxVXYxbkJqWGtuNVYzRFI5QXxBQ3Jtc0tsZnJ0cENjZ3E1Y1dVTXE2VWV2em9mdFBqYU5jTXpNZTk0RFRiSS1iYjRUeU55Vi1Md1JpT1IwRnBCdm9oakJTbHZLdUl1dnFJcWZEcjFNWE1QNEtmZ2lOaVZVVS1ad1FrZkY5R3daU2JuYnJfYkVubw&q=https%3A%2F%2Fwww.kaggle.com%2Fheesoo37%2F120-years-of-olympic-history-athletes-and-results&v=XruOBp7yPXU


SELECT 
    *
FROM
    olympic_schema.athlete_events

1) How many olympic games have been held?
SELECT 
    COUNT(DISTINCT Games) AS total_olympic_games
FROM
    olympic_schema.athlete_events

2) List all the Olympic Games so far
SELECT DISTINCT
    year, season, city
FROM
    olympic_schema.athlete_events
ORDER BY year

3) Total number of nations that participated in each olympics
SELECT 
    COUNT(DISTINCT NOC) as total_countries, games 
FROM
    olympic_schema.athlete_events
GROUP BY Games

4) Which Sports were just played only once in the olympics?
with t1 as
          	(select distinct games, sport
          	from olympic_schema.athlete_events),
          t2 as
          	(select sport, count(*) as no_of_games
          	from t1
          	group by sport)
      select t2.*, t1.games
      from t2
      join t1 on t1.sport = t2.sport
      where t2.no_of_games = 1
      order by t1.sport

5 Top 5 athletes who have won the most gold medals.
    with t1 as
            (select name, team, count(*) as total_gold_medals
            from olympic_schema.athlete_events
            where medal = 'Gold'
            group by name, team
            order by total_gold_medals desc),
        t2 as
            (select *, dense_rank() over (order by total_gold_medals desc) as rnk
            from t1)
    select name, team, total_gold_medals
    from t2
    where rnk <= 5;








