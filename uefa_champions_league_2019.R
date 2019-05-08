library(igraph)

# 1. ----- READ DATA FILES-----

group_stage <- read.csv(("champions_league_2019_gs.csv"), header=TRUE, sep = ";", row.names = 1, check.names = FALSE)
round_of_16 <- read.csv(("champions_league_2019_r16.csv"), header=TRUE, sep = ";", row.names = 1, check.names = FALSE)
quarterf <- read.csv(("champions_league_2019_quarterf.csv"), header=TRUE, sep = ";", row.names = 1, check.names = FALSE)
semif <- read.csv(("champions_league_2019_semif.csv"), header=TRUE, sep = ";", row.names = 1, check.names = FALSE)
final <- read.csv(("champions_league_2019_final.csv"), header=TRUE, sep = ";", row.names = 1, check.names = FALSE)

# Additional files containing team country, team victories and team group
champ_data <- read.csv(("champions_league_2019_data.csv"), header=TRUE, sep = ";", check.names=FALSE)

# 2. ----- CREATE DATA FRAMES-----

group_stage_df <- as.data.frame(group_stage)
round_of_16_df <- as.data.frame(round_of_16)
quarterf_df <- as.data.frame(quarterf)
semif_df <- as.data.frame(semif)
final_df <- as.data.frame(final)
champ_data_df <- as.data.frame(champ_data)

# 3. ----- CONVERT DATA FRAMES TO MATRICES -----

group_stage_m <- as.matrix(group_stage_df)
round_of_16_m <- as.matrix(round_of_16_df)
quarterf_m <- as.matrix(quarterf_df)
semif_m <- as.matrix(semif_df)
final_m <- as.matrix(final_df)
champ_data_m <- as.matrix(champ_data_df)

# 4. ----- REPLACE 'NA' VALUES WITH '0' -----

group_stage_m[is.na(group_stage_m)] <- 0 
round_of_16_m[is.na(round_of_16_m)] <- 0
quarterf_m[is.na(quarterf_m)] <- 0
semif_m[is.na(semif_m)] <- 0
final_m[is.na(final_m)] <- 0

# 5. ----- CONVERT 'champions_league_2019_data' TO VECTORS -----

team_name <- as.vector(champ_data_df$Team)
team_country <- as.vector(champ_data_df$Country)
team_group <- as.vector(champ_data_df$Group)

group_stage_victories <- as.vector(champ_data_df$`Gstage vic`)
round_of_16_victories <- as.vector(champ_data_df$Tvic1)
quarterf_victories <- as.vector(champ_data_df$Tvic2)
semif_victories <- as.vector(champ_data_df$Tvic3)
final_victories <- as.vector(champ_data_df$Tvic3)

# 6. ----- CREATE GRAPH OBJECTS -----

group_stage_g <- graph_from_adjacency_matrix(group_stage_m, mode = "undirected")
round_of_16_g <- graph_from_adjacency_matrix(round_of_16_m, mode = "undirected")
quarterf_g <- graph_from_adjacency_matrix(quarterf_m, mode = "undirected")
semif_g <- graph_from_adjacency_matrix(semif_m, mode = "undirected")
final_g <- graph_from_adjacency_matrix(final_m, mode = "undirected")

# 7. ----- SET ATTRIBUTES TO NODES AND EDGES -----

# Group stage
V(group_stage_g)$country <- team_country
V(group_stage_g)$victories <- group_stage_victories
V(group_stage_g)$group <- team_group

# Round of 16
V(round_of_16_g)$country <- team_country
V(round_of_16_g)$victories <- round_of_16_victories
V(round_of_16_g)$group <- team_group

# Quarter-finals
V(quarterf_g)$country <- team_country
V(quarterf_g)$victories <- quarterf_victories
V(quarterf_g)$group <- team_group

# Semi-finals
V(semif_g)$country <- team_country
V(semif_g)$victories <- semif_victories
V(semif_g)$group <- team_group

# Final
V(final_g)$country <- team_country
V(final_g)$victories <- semif_victories
V(final_g)$group <- team_group
V(final_g)$team <- team_name

# 8. ----- PLOT IGRAPH OBJECTS -----

par(mar = c(1,1,1,1))

# Group stage
plot(group_stage_g,
     vertex.color = "darkturquoise",
     vertex.size = V(group_stage_g)$victories * 3,
     vertex.frame.color = "black",
     vertex.label.color = "black",
     vertex.label.cex = .50,
     vertex.label.dist = 0,
     vertex.label.degree = 0,
     edge.width = 2,
     main = "Group stage network",
     layout = layout_with_fr(group_stage_g))

# Round of 16
plot(round_of_16_g,
     vertex.color = "darkturquoise",
     vertex.size = V(round_of_16_g)$victories * 3,
     vertex.frame.color = "black",
     vertex.label.color = "black",
     vertex.label.cex = .50,
     vertex.label.dist = 0,
     vertex.label.degree = pi,
     edge.width = 2,
     main = "Round of 16 network",
     layout = layout_with_fr(round_of_16_g))

# Quarter-finals
plot(quarterf_g,
     vertex.color = "darkturquoise",
     vertex.size = V(quarterf_g)$victories * 3,
     vertex.frame.color = "black",
     vertex.label.color = "black",
     vertex.label.cex = .50,
     vertex.label.dist = .50,
     vertex.label.degree = 0,
     edge.width = 2,
     main = "Quarter-finals network",
     layout = layout_with_fr(quarterf_g))

# Semi-finals
plot(semif_g,
     vertex.color = "darkturquoise",
     vertex.size = V(semif_g)$victories * 3,
     vertex.frame.color = "black",
     vertex.label.color = "black",
     vertex.label.cex = .50,
     vertex.label.dist = 0,
     vertex.label.degree = 0,
     edge.width = 2,
     main = "Semi-finals network",
     layout = layout_with_fr(semif_g))

# Final
final_path <- shortest_paths(final_g,
                            from = V(final_g)[team_name == "Liverpool"],
                            to =  V(final_g)[team_name == "Tottenham"],
                            output = "both")

# Edge color variable to plot the path between 'Liverpool' and 'Tottenham'
ecol <- rep("gray80", ecount(final_g))
ecol[unlist(final_path$epath)] <- "firebrick1"
                            
# Edge width variable to plot the previous path
ew <- rep(2, ecount(final_g))
ew[unlist(final_path$epath)] <- 4

# Node color variable to plot the previous path
vcol <- rep("gray40", vcount(final_g))
vcol[unlist(final_path$vpath)] <- "gold"

plot(final_g,
     vertex.color = vcol,
     vertex.size = V(semif_g)$victories * 3,
     vertex.frame.color = "black",
     vertex.label.color = "black",
     vertex.label.cex = .50,
     vertex.label.dist = 0,
     vertex.label.degree = 0,
     edge.width = ew,
     edge.color = ecol,
     main = "Final network",
     layout = layout_with_fr(semif_g))


# Community detection

team_community <- cluster_edge_betweenness(semif_g)

plot(team_community, semif_g,
     vertex.label.cex = .50,
     vertex.label.color = "black",
     edge.color = "black",
     main = "Champions League Groups Network",
     layout = layout_with_fr(semif_g)) 


# 9. ----- ANALYZE NETWORKS, NODES, AND EDGES -----

# Brief analysis of 'Group stage' 
is.directed(group_stage_g) # Is the object directed? FALSE
is.weighted(group_stage_g) # Is the object weighted? FALSE
E(group_stage_g) # Examining the edges of the object | Who plays against who
V(group_stage_g) # Examining vertices of the object | Teams
gsize(group_stage_g) # Counting number of edges 
gorder(group_stage_g) # Counting vertices |  32 Teams
vertex_attr(group_stage_g) # View vertices attributes | 'name', 'country', 'victories', 'group'

# Brief analysis of 'Round of 16'
E(round_of_16_g) # Examining the edges of the object
gsize(round_of_16_g) # Counting number of edges

# Brief analysis of 'Quarter-finals'
E(quarterf_g) # Examining the edges of the object
gsize(quarterf_g) # Counting number of edges 

# Brief analysis of 'Semi-finals'
E(semif_g) # Examining the edges of the object
gsize(semif_g) # Counting number of edges 

# Brief analysis of 'Final'
adjacent_vertices(semif_g, c("Liverpool", "Tottenham")) # Teams that played against Ajax and Liverpool

# --------------------------------
# ---------- VISNETWORK ----------

library(visNetwork)

# 10. ----- CONVERT GRAPH OBJECT 'final_g' TO VISNETWORK OBJECT -----

final_vis <- toVisNetworkData(final_g)

# 11. ----- SET ATTRIBUTES AND FEATURES TO NODES AND EDGES -----

teams_nodes <- final_vis$nodes
teams_edges <- final_vis$edges

# Adding attributes and features
teams_nodes$group <- teams_nodes$group
teams_nodes$title <- teams_nodes$id

nodes_size <- V(final_g)$size <- teams_nodes$victories * 3
teams_nodes$size <- nodes_size

teams_nodes$label <- teams_nodes$id
teams_nodes$shadow <- TRUE

# 12. ----- PLOT VISNETWORK OBJECT -----

champ_visnet <- visNetwork(teams_nodes, teams_edges,
                           main = " Champions League 2019 Network",
                           submain = "Season 2018-19",
                           footer = "By Pablo Alvarez Baeza",
                           width = "100%", height = "575px")

champ_visnet1 <-  visOptions(champ_visnet,
                             highlightNearest = TRUE,
                             selectedBy = "country")


# Adding a legend
champ_visnet2 <- visLegend(champ_visnet1, main = "Groups")

# Final Plot
champ_visnet2

visSave(champ_visnet2, file = "index.html")
