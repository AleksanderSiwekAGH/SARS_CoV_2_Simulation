function [isItValid] = isOneStateTransitionValid(transitionMatrix, currentState, nextState)
    isItValid =  transitionMatrix(currentState, nextState);
end

