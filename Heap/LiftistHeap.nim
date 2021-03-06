proc COMP*(x , y : int) : bool = return x < y
proc INF*(t : typedesc[int]) : int = return (int)(1e18)

type
  LiftistNode*[T] = ref object
    ## Node of Liftist Heap
    val* : T
    l : LiftistNode[T]
    r : LiftistNode[T]
  LiftistHeap*[T] = object
    ## Liftist Heap Object
    root* : LiftistNode[T]

proc newLiftistNode[T](val : T) : LiftistNode[T] =
  var n = new LiftistNode[T]
  n.val = val
  n.l = nil
  n.r = nil
  return n

proc newLiftistHeap*[T]() : LiftistHeap[T] = return LiftistHeap[T](root : nil) ## create new Liftist Heap Object

proc merge[T](x , y : var LiftistNode[T]) : LiftistNode[T] =
  if x == nil: return y
  if y == nil: return x
  if not COMP(x.val , y.val): swap(x , y)
  x.r = merge(x.r , y)
  swap(x.l , x.r)
  return x

proc value[T](x : LiftistNode[T]) : T =
  if x == nil: return T.INF
  return x.val

proc meld*[T](x , y : var LiftistHeap[T]) =
  ## y Liftist Heap merge to x. amortized O(logN)
  x.root = merge(x.root , y.root)
  y.root = nil

proc push*[T](x : var LiftistHeap[T] , val  : T) =
  ## the new Node that has value val push to x. amortized O(logN)
  var n = newLiftistNode(val)
  x.root = merge(x.root , n)


proc top*[T](x : LiftistHeap[T]) : T =
  ## the top value of Liftist Heap. takes O(1)
  return x.root.value

proc snd*[T](x : LiftistHeap[T]) : T =
  ## the second value of Liftist Heap. takes O(1)
  if x.root == nil: return T.INF
  if COMP(x.root.l.value, x.root.r.value): return x.root.l.value
  return x.root.r.value

proc pop*[T](x : var LiftistHeap[T]) =
  ## remove the top value of Liftist Heap. amortized O(logN)
  x.root = merge(x.root.l , x.root.r)

proc empty*[T](x : LiftistHeap[T]) : bool = return x.root == nil ## if the Liftist Heap is empty, return true. takes O(1)



