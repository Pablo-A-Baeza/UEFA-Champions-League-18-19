# UEFA-Champions-League-18-19
A brief Social Network Analysis of this year UEFA Champions League

## Sources
The data for this repository is freely available to anyone wishing to see it. It's taken from the official website of [UEFA Champions League](https://www.uefa.com/uefachampionsleague/index.html). Particularly, I used the statistics available for each team [here](https://www.uefa.com/uefachampionsleague/season=2019/statistics/round=2000980/clubs/index.html) and the calendar for each game [here](https://www.uefa.com/uefachampionsleague/season=2019/matches/#/dw/1141) Starting from *'Group Stage Draw - 30 AUG 2018'*

## Data
This repository contains two folders.

- ### **Data files**
<details>
    <summary>Click to expand</summary>
    
    1. champions_league_2019_data: Data for each of the teams competing, each column represents.
        - Team: 32 teams that compited in this competition starting from 'Group Stage Draw'
        - Country: Acronym for each of the countries corresponding to each team 
        - Group: Corresponding group to each team 
        - Gstage vic: Total team victories for the 'Group Stage Round'
        - RF16 vic: Total team victories for the 'Round of 16'
        - Tvic1: Total team victories up to 'Round of 16' (inclusive)
        - Qf vic: Total team victories for the 'Quarter-Finals Round' 
        - Tvic2: Total team victories up to 'Quarter-Finals Round' (inclusive)
        - Sf vic: Total team victories for the 'Semi-Finals Round' 
        - Tvic3: Total team victories up to 'Semi-Finals Round' (inclusive)
    
    2. champions_league_2019_gs: Group Stage matrix
    3. champions_league_2019_r16: Round of 16 matrix
    4. champions_league_2019_quarterf: Quarter-Finals matrix
    5. champions_league_2019_semif: Semi-Finals matrix
    6. champions_league_2019_final: Final matrix
</details>
    
- ### **Plots**
<details>
    <summary>Click to expand</summary>
    
    - champions_league_2019_gs_plot: Group Stage (igraph)
    - champions_league_2019_r16_plot: Round of 16 (igraph)
    - champions_league_2019_quarterf_plot: Quarter-Finals (igraph)
    - champions_league_2019_semif_plot: Semi-Finals (igraph)
    - champions_league_2019_final_plot: Final (igraph)
    - champions_league_2019_community: Community detection (igraph)
</details>
      
## Methodology 
The process of this Social Network Analysis was the follwing:

**Excel**
<details>
    <summary>Click to expand</summary>
    
    1. Create adjacency matrices for each of the rounds of the tournament
    2. Create a spreadsheet with the general information of each of the teams competing in the tournament
    
</details>

**R**
<details>
    <summary>Click to expand</summary>
    
    1. Read data files
    2. Create data frames
    3. Convert data frames to matrices
    4. Replace 'NA values with '0'
    5. Convert 'champions_league_2019_data' to vectors
    6. Create graph objects
    7. Set attributes to nodes (teams) and edges (links)
    8. Plot igraph graphs
    9. Analyze networks, nodes, and edges
    10. Convert graph object 'final_g' to visNetwork object
    11. Set attributes and features to nodes and edges
    12. Plot visNetwork object
</details>
    
## Interpretation

All networks in this repository are:
* **Undirected:** Teams have a recriprocal relationship with those teams they competed with. Matrices are therefore symmetric
* **Unweighted:** Each team has either a value of 1 (if they have played at least once against team 'X') or 0 otherwise
* **One-mode:** Columns and rows represent the same nodes

Additionally,
- **Nodes:** Each team is represented with a circle depicting its total victories. The bigger the circle, the more victories the time has
- **Edges:** A link between two teams depicts whether those teams have played at least once against each other

This is the network corresponding to the last round of the tournament 'final'. In short, we can see 32 teams, among these teams, *Liverpool* and *Tottenham* are highlighted because these two teams are the ones that have reached the final round of the competition, thus they will play the final game (**Saturday  1 June 2019, 21:00h CET**). These two teams are also the ones with more edges (6 each one).
An inevitable conclusion supporting this graph is that (unfortunately) the team with the most victories (Barcelona = 8) is not the one that will play the final. Therefore, we could conclude that teams don't just have to win games, but they have to win **key** games.

![](https://github.com/Pablo-A-Baeza/UEFA-Champions-League-2018-19-Network/blob/master/Plots/champions_league_2019_final_plot.jpeg)

Check the final interactive network [here](https://pablo-a-baeza.github.io/Example_Test/index.html)
[here](https://pablo-a-baeza.github.io/UEFA-Champions-League-2018-19-Network/index.html)

## Acknowledgments
A great credit of the work of this repository goes to @ and @ . Their resources to learn social network analysis in R are unvaluable! An example of these are:
- **Katya Ognyanova** [Ognyanova, K. (2018) Network visualization with R.](https://kateto.net/network-visualization)
- **Pablo Barberá** [Introduction to Social Network Analysis with R](http://pablobarbera.com/big-data-upf/html/02a-networks-intro-visualization.html)


For more information/questions feel free to contact me!
- [LinkedIn](www.linkedin.com/in/pabloalvarezbaeza)
- Gmail: pablo.alvarez.baeza@gmail.com
