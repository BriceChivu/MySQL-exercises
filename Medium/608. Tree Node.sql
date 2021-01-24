-- Given a table tree, id is identifier of the tree node and p_id is its parent node's id.

-- +----+------+
-- | id | p_id |
-- +----+------+
-- | 1  | null |
-- | 2  | 1    |
-- | 3  | 1    |
-- | 4  | 2    |
-- | 5  | 2    |
-- +----+------+
-- Each node in the tree can be one of three types:
-- Leaf: if the node is a leaf node.
-- Root: if the node is the root of the tree.
-- Inner: If the node is neither a leaf node nor a root node.
--  

-- Write a query to print the node id and the type of the node. Sort your output by the node id. The result for the above sample is:
--  

-- +----+------+
-- | id | Type |
-- +----+------+
-- | 1  | Root |
-- | 2  | Inner|
-- | 3  | Leaf |
-- | 4  | Leaf |
-- | 5  | Leaf |
-- +----+------+

drop table if exists tree;

CREATE TABLE tree (
  `id` INTEGER,
  `p_id` VARCHAR(4)
);

INSERT INTO tree
  (`id`, `p_id`)
VALUES
  ('1', Null),
  ('2', '1'),
  ('3', '1'),
  ('4', '2'),
  ('5', '2');
  
#Solution 1:
select distinct tree1_id,
case when p_id is null then 'root'
when tree2_id is null then 'leaf'
else 'inner' end as type
from(
select tree2.id as tree2_id, tree1.id as tree1_id, tree1.p_id
from tree tree1
left join tree tree2 on tree1.id=tree2.p_id
) tmp;


#Solution 2:
select id,
case when p_id is null then 'root'
when id in (select p_id from tree) then 'inner'
else 'leaf' end as type
from tree;
