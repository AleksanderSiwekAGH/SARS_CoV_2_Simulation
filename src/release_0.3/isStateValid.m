function [isItValid] = isStateValid(matrix, state)
    isItValid = matrix(state(1), state(2));
end

