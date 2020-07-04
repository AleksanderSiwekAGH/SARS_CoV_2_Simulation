function [QNew, itersStateStartNew] = makeTransition(item, newState, Q, itersStateStart, currentIter)
    x = item(1);
    y = item(2);
    Q(x, y) = newState;
    QNew = Q;
    itersStateStart(x, y) = currentIter;
    itersStateStartNew = itersStateStart;
end

