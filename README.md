# cis191finalproject

Fall 2019

Oracle of Kevin Bacon (IMDB web scraper/ crawler)

Instructions to run: in a bash shell, run ./imdb.sh

Description: The scraper/crawler will create a file called bacon.txt which it will populate with actors and their Bacon number. Keep in mind that there are over 300,000 actors listed on the IMDB site, so the entire list will take a long time! Given how large an IMDB html file is, it will take many hours to run. 
There are two types of pages on IMDB that I am concerned with -- actor pages which link to the movies the actor has acted in and movie pages which link to the actors in the movie. I do a BFS traversal of IMDB started from Kevin Bacon's actor page. The first iteration constitudes going to every one of Bacon's movies and adding all of the movie's actors to my actors list. Thus, we have all people with Bacon number of 1. I also keep a cache of all actors seen so far so we don't infinite loop and we correctly classify each actor with his/her correct Bacon number. Furthermore, we need to limit the movies we visit. Each actor may also have movies he/she directed, wrote, or produced, but we are only concerned with movies the actor acted in. We do this by isolating "actor" in a corresponding div tag. Another thing we need to consider is not including films that aren't full feature films. For instance, we do not want to include "short" films so we filter this out in a regex. Filtering "short" films was especially hard because the "(short)" text appears after the movie link. Finally, we only include cast members on the movie pages, not directors, makeup department, sound department, etc. 
