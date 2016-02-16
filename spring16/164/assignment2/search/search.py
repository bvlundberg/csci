# Brandon Lundberg
# 106352122
# 3 February 2016

# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]

def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first.

    Your search algorithm needs to return a list of actions that reaches the
    goal. Make sure to implement a graph search algorithm.

    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:

    print "Start:", problem.getStartState()
    print "Is the start a goal?", problem.isGoalState(problem.getStartState())
    print "Start's successors:", problem.getSuccessors(problem.getStartState())
    """
    "*** YOUR CODE HERE ***"
    moves = util.Stack()
    visited = []
    result = []

    state = problem.getStartState()
    dfs_rec(state, moves, visited, problem)


    while not moves.isEmpty():
        x = moves.pop()
        result.append(x)
    reverse = result.reverse()
    return result

def dfs_rec(state, moves, visited, problem):
    if problem.isGoalState(state):
        return True
    if state in visited:
        return False
    visited.append(state)
    succ = problem.getSuccessors(state)
    for s in succ:
        moves.push(s[1])
        result = dfs_rec(s[0], moves, visited, problem)
        if result:
            return True
        else:
            remove = moves.pop()
    return False



def breadthFirstSearch(problem):
    """Search the shallowest nodes in the search tree first."""
    "*** YOUR CODE HERE ***"
    # Moves are the expanded states
    # Each element in parent is the parent for the node and the direction to get to it from parent
    # Visited is a list of the nodes visited
    moves = util.Queue()
    visited = []
    # Start and stop points of the search
    start = problem.getStartState()
    
    root = (start, [])
    moves.push(root)
    # Visit the initial node
    visited.append(start)
    while not moves.isEmpty():
        curr = moves.pop()
        # If destination is found
        if problem.isGoalState(curr[0]):
            return curr[1]
        for s in problem.getSuccessors(curr[0]):
            if s[0] not in visited:
                moves.push((s[0], curr[1]+[s[1]]))
                # Visit node as it is enqueued, not dequeued (in case another node leads to it)
                visited.append(s[0])

    return []

def uniformCostSearch(problem):
    """Search the node of least total cost first."""
    "*** YOUR CODE HERE ***"
    moves = util.PriorityQueue()
    parents = {}
    frontier = {}
    visited = []
    # Start and stop points of the search
    start = problem.getStartState()
    goal = None

    moves.push((start, '', 0), 0)
    # Visit the initial node
    visited.append(start)
    while not moves.isEmpty():
        curr = moves.pop()
        # print curr
        visited.append(curr[0])
        # If destination is found
        if problem.isGoalState(curr[0]):
            goal = curr[0]
            break
        for s in problem.getSuccessors(curr[0]):
            if s[0] not in visited:
                #print "Successor", s[2]
                #print "Frontier", frontier[s[0]]
                if s[0] not in frontier:
                    moves.push((s[0], s[1], curr[2] + s[2]), curr[2] + s[2])
                    # set parent and direction to the current node in the parents list
                    frontier[s[0]] = s[2]
                    parents[s[0]] = (curr[0], s[1])
                elif (s[0] in frontier) and (s[2] < frontier[s[0]]):
                    frontier[s[0]] = s[2]
                    parents[s[0]] = (curr[0], s[1]) 


    result = []
    this = goal
    while this != start:
        result = [parents[this][1]] + result
        this = parents[this][0]
    return result

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    "*** YOUR CODE HERE ***"
    costs = {}
    frontier = util.PriorityQueue()

    start = problem.getStartState()
    startstring = str(start)
    print startstring
    frontier.push((start, []), 0)
    costs[startstring] = 0


    while not frontier.isEmpty():
        node, moves = frontier.pop()
        nodestring = str(node)
        if problem.isGoalState(node):
            return moves
        for newnode, move, cost  in problem.getSuccessors(node):
            newnodestring = str(newnode)
            newcost = costs[nodestring] + cost
            if newnodestring not in costs or newcost < costs[newnodestring]:
                costs[newnodestring] = newcost
                newpriority = newcost + heuristic(newnode, problem)
                frontier.push((newnode, moves+[move] ), newpriority)
    return []


# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
