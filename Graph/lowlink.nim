import sequtils
type
  Edge* = object
    ## Edge Object , edit this to add more information like distance.
    to : int
  Graph*[E] = seq[seq[E]]
    ## Graph Object.

proc newGraph*[E](n : int) : Graph[E] =
  ## create n size new Graph.
  var g : Graph[E] = newSeqWith(n , newSeq[E](0))
  return g

proc size*[E](g : Graph[E]) : int =
  ## size of Graph
  return g.len

proc lowlink*[E](g : Graph[E]) : seq[tuple[a : int , b : int]] =
  ## get bridges of graph.takes O(N)
  var 
    bridge : seq[tuple[a : int , b : int]] = @[]
    n = g.size
    used = newSeqWith(n , false)
    ord = newSeqWith(n , 0)
    low = newSeqWith(n , 0)
    dfs : proc(v , K , f : int) : int
  dfs = proc(v , K , f : int) : int =
    var k = K
    used[v] = true
    ord[v] = k
    low[v] = ord[v]
    inc(k)
    for e in g[v]:
      if not used[e.to]:
        k = dfs(e.to , k , v)
        low[v] = min(low[v] , low[e.to])
        if ord[v] < low[e.to]: bridge.add((min(v , e.to) , max(v , e.to)))
      elif e.to != f: low[v] = min(low[v] , ord[e.to])
    return k
  discard dfs(0,0,-1)
  return bridge