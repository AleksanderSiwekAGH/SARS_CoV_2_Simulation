function [isItValid] = isWholeTransitionValid(matrix1, matrix2, currentState, nextState)
    if (currentState(1) ~= nextState(1))
        if (currentState(2) ~= nextState(2))
            isItValid = 0;
        else
            isItValid = isOneStateTransitionValid(matrix1, currentState(1), nextState(1));
        end
    else
    	isItValid = isOneStateTransitionValid(matrix2, currentState(2), nextState(2));
    end
end

