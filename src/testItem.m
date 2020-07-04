
todaysTests = todaysTests + 1;
if (Q2(x, y) == infected || Q2(x, y) == infected_and_sick)
    if (confirmed(x, y) ~= 1)
        todaysConfirmedCases = todaysConfirmedCases + 1;
        confirmed(x, y) = 1;
    end
end