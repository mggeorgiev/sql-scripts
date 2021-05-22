/*source: https://www.red-gate.com/simple-talk/sql/t-sql-programming/handling-graphs-sql/*/

USE data_science;
GO

CREATE TABLE graphs.Nodes
(node CHAR(1) NOT NULL PRIMARY KEY);
 
CREATE VIEW graphs.Complete_Graph (node_1, node_2) 
AS
SELECT N1.node, N2.node
  FROM Nodes AS N1
       CROSS JOIN 
       Nodes AS N2 
 WHERE N1.node <> N2.node; 

/*Disconnected Graphs*/

CREATE TABLE graphs.Directed_Graph
(in_node CHAR(1) NOT NULL, 
 out_node CHAR(1) NOT NULL, 
 CHECK (in_node <> out_node), 
 PRIMARY KEY (in_node, out_node));
 
INSERT INTO graphs.Directed_Graph
VALUES
('A', 'B'), ('B', 'A'), ('B', 'C'), ('C', 'B'), 
('A', 'C'), ('C', 'A'), 
('D', 'E'), ('E', 'D');

CREATE TABLE graphs.Base_Graph
(in_node CHAR(1) NOT NULL, 
 out_node CHAR(1) NOT NULL, 
 CHECK (in_node < out_node), 
 PRIMARY KEY (in_node, out_node));
 
INSERT INTO graphs.Base_Graph
VALUES
('A', 'B'), ('B', 'C'), 
('D', 'E');
 
CREATE VIEW graphs.Undirected_Graph (node_1, node_2)
AS
SELECT in_node, out_node FROM graphs.Base_Graph 
UNION ALL
SELECT out_node, in_node FROM graphs.Base_Graph;

CREATE TABLE graphs.Subgraphs
(subgraph_name CHAR(1) NOT NULL, 
 member_node CHAR(1) NOT NULL, 
PRIMARY KEY (subgraph_name, member_node));
 
INSERT INTO graphs.Subgraphs
VALUES
('A', 'A'), 
('A', 'B'), 
('A', 'C'), 
('D', 'D'), 
('D', 'E');
 
SELECT subgraph_name
  FROM graphs.Subgraphs AS S 
 WHERE subgraph_name = @in_subgraph_name
   AND member_node IN (@in_node_1, @in_node_2)
 GROUP BY subgraph_name
HAVING COUNT(member_node) = 2;
