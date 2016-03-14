# multiAgents.py
# --------------
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


from util import manhattanDistance
from game import Directions
import random, util

from game import Agent

class ReflexAgent(Agent):
    """
      A reflex agent chooses an action at each choice point by examining
      its alternatives via a state evaluation function.

      The code below is provided as a guide.  You are welcome to change
      it in any way you see fit, so long as you don't touch our method
      headers.
    """


    def getAction(self, gameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {North, South, West, East, Stop}
        """
        # Collect legal moves and successor states
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        oldFood = currentGameState.getFood().asList()
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood().asList()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]
        newGhostPositions = successorGameState.getGhostPositions()
        "*** YOUR CODE HERE ***"       
        '''
        SCORE: 2/4
        if newPos in newGhostPositions:
          print("Ghost")
          return 0
        if len(oldFood) == len(newFood):
          mindist = 9999
          for food in newFood:
            dist = manhattanDistance(newPos, food)
            if dist < mindist:
              mindist = dist
          print("Distance: ", mindist)
          return 1 / float(mindist)
        print("Food")
        return 2
        '''
        for ghost in newGhostPositions:
          if manhattanDistance(newPos, ghost) < 3:
            return -1
        if len(oldFood) == len(newFood):
          mindist = 9999
          for food in newFood:
            dist = manhattanDistance(newPos, food)
            if dist < mindist:
              mindist = dist
          return 1 / float(mindist)
        return 2

def scoreEvaluationFunction(currentGameState):
    """
      This default evaluation function just returns the score of the state.
      The score is the same one displayed in the Pacman GUI.

      This evaluation function is meant for use with adversarial search agents
      (not reflex agents).
    """
    return currentGameState.getScore()

class MultiAgentSearchAgent(Agent):
    """
      This class provides some common elements to all of your
      multi-agent searchers.  Any methods defined here will be available
      to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

      You *do not* need to make any changes here, but you can if you want to
      add functionality to all your adversarial search agents.  Please do not
      remove anything, however.

      Note: this is an abstract class: one that should not be instantiated.  It's
      only partially specified, and designed to be extended.  Agent (game.py)
      is another abstract class.
    """

    def __init__(self, evalFn = 'scoreEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)

class MinimaxAgent(MultiAgentSearchAgent):
    """
      Your minimax agent (question 2)
    """
    def getAction(self, gameState):
        """
          Returns the minimax action from the current gameState using self.depth
          and self.evaluationFunction.
          Here are some method calls that might be useful when implementing minimax.
          gameState.getLegalActions(agentIndex):
            Returns a list of legal actions for an agent
            agentIndex=0 means Pacman, ghosts are >= 1
          gameState.generateSuccessor(agentIndex, action):
            Returns the successor game state after an agent takes an action
          gameState.getNumAgents():
            Returns the total number of agents in the game
        """
       
    
    def getAction(self, gameState):
        """
          Returns the minimax action from the current gameState using self.depth
          and self.evaluationFunction.

          Here are some method calls that might be useful when implementing minimax.

          gameState.getLegalActions(agentIndex):
            Returns a list of legal actions for an agent
            agentIndex=0 means Pacman, ghosts are >= 1

          gameState.generateSuccessor(agentIndex, action):
            Returns the successor game state after an agent takes an action

          gameState.getNumAgents():
            Returns the total number of agents in the game
        """
        "*** YOUR CODE HERE ***"
        
        def minimaxRec(gameState, depth, agent, isMax, isRoot):
          # Base Case
          if depth == 0 or gameState.isWin() or gameState.isLose():
            return self.evaluationFunction(gameState)
          # Get legal moves for the agent
          legalMoves = gameState.getLegalActions(agent)
          #PACMANS TURN
          if isMax:
            # Looking for best option (Max)
            maxscore = -99999
            newState = None
            action = None
            for move in legalMoves:
              newState = gameState.generateSuccessor(agent, move)
              # Recursive call with the same depth to the first ghost agent
              value = minimaxRec(newState, depth, 1, False, False)
              # Set new max if applicable
              if value > maxscore:
                maxscore = value
                action = move
            # Return the correct move if at the root, otherwise the score at this depth
            if isRoot:
              return action
            else:
              return maxscore
          # GHOST AGENTS TURN
          else:
            # Looking for worst option (Min)
            minscore = 99999
            newState = None
            for move in legalMoves:
              newState = gameState.generateSuccessor(agent, move)
              # PACMAN IS NEXT
              # Recursive call to get back to Pacman's turn
              if (agent + 1) % gameState.getNumAgents() == 0:
                value = minimaxRec(newState, depth - 1, 0, True, False)
              # ANOTHER GHOST AGENT IS NEXT
              # Recursive call for next ghost's moves
              else:
                value = minimaxRec(newState, depth, agent + 1, False, False)
              # Set new min if applicable
              if value < minscore:
                minscore = value
            return minscore 

        # Call recursive function initially
        return minimaxRec(gameState, self.depth, 0, True, True)

class AlphaBetaAgent(MultiAgentSearchAgent):
    """
      Your minimax agent with alpha-beta pruning (question 3)
    """

    def getAction(self, gameState):
        """
          Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"
        def abPruningRec(gameState, depth, alpha, beta, agent, isMax, isRoot):
          # Base Case
          if depth == 0 or gameState.isWin() or gameState.isLose():
            return self.evaluationFunction(gameState)
          # Get legal moves for the agent
          legalMoves = gameState.getLegalActions(agent)
          #PACMANS TURN
          if isMax:
            # Looking for best option (Max)
            maxscore = -99999
            newState = None
            action = None
            for move in legalMoves:
              newState = gameState.generateSuccessor(agent, move)
              # Recursive call with the same depth to the first ghost agent
              value = abPruningRec(newState, depth, alpha, beta, 1, False, False)
              # Set new max if applicable
              if value > maxscore:
                maxscore = value
                action = move
              # Evaluate alpha-beta conditions
              if value > alpha:
                alpha = value
              # break loop
              if beta < alpha:
                break
            # Return the correct move if at the root, otherwise the score at this depth
            if isRoot:
              return action
            else:
              return maxscore
          # GHOST AGENTS TURN
          else:
            # Looking for worst option (Min)
            minscore = 99999
            newState = None
            for move in legalMoves:
              newState = gameState.generateSuccessor(agent, move)
              # PACMAN IS NEXT
              # Recursive call to get back to Pacman's turn
              if (agent + 1) % gameState.getNumAgents() == 0:
                value = abPruningRec(newState, depth - 1, alpha, beta, 0, True, False)
              # ANOTHER GHOST AGENT IS NEXT
              # Recursive call for next ghost's moves
              else:
                value = abPruningRec(newState, depth, alpha, beta, agent + 1, False, False)
              # Set new min if applicable
              if value < minscore:
                minscore = value
              # Evaluate alpha-beta conditions
              if value < beta:
                beta = value
              # break loop
              if beta < alpha:
                break
            return minscore 

        # Call recursive function initially
        return abPruningRec(gameState, self.depth, -99999, 99999, 0, True, True)

class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    def getAction(self, gameState):
        """
          Returns the expectimax action using self.depth and self.evaluationFunction

          All ghosts should be modeled as choosing uniformly at random from their
          legal moves.
        """
        "*** YOUR CODE HERE ***"
        util.raiseNotDefined()

def betterEvaluationFunction(currentGameState):
    """
      Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
      evaluation function (question 5).

      DESCRIPTION: <write something here so we know what you did>
    """
    "*** YOUR CODE HERE ***"
    util.raiseNotDefined()

# Abbreviation
better = betterEvaluationFunction

