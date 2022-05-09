include "vertex_set_fn.mzn";
include "is_adj_matrix_square.mzn";
include "order_fn.mzn";
include "globals.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph
  size: an integer representing the size of the clique. Can be a decision-variable

  This function returns a set of vertexes that compose a clique with the specified size
*/

function var set of int: clique(array[int,int] of int: graph, var int: size) =
let {
  set of int: V = vertex_set(graph);
  var set of V: clique_set;
  array[V] of var bool: bool_set;

  constraint is_adj_matrix_square(graph);
  constraint assert(dom(size) subset 1..order(graph), "The domain of the clique size must be [1..order(graph)]", true);

  constraint card(clique_set) == size;
  constraint link_set_to_booleans(clique_set, bool_set);
  constraint forall(u,v in V, where u!=v) ( (bool_set[u] /\ bool_set[v]) -> (graph[u,v] != 0 /\ graph[v,u] != 0) );
}
in (
  clique_set
);