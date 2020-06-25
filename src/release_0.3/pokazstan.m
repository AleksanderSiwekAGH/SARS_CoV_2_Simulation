

function planszaZwrotna = pokazstan(plansza,nazwaPliku,x,y)

M = importdata(nazwaPliku,',');
[w, k] = size(M);

for n=1:w
	for m=1:k
		plansza(x+n,y+m) = M(n,m);
	end
end

[wP,kP] = size(plansza);
planszaZwrotna = zeros(wP,kP);


sick_symptoms_no_sec_measures=1;
healthy_protecting_others=2;

healthy_no_sec_measures=4;
healthy_organising_protection=5;

 sick_no_symptoms_no_sec_measures=8;
 sick_no_symptoms_infecting=9;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[I1,J1] = find(plansza==sick_symptoms_no_sec_measures);
liczbajeden = length(I1);


for n=1:liczbajeden
    planszaZwrotna(I1(n),J1(n)) = plansza(I1(n),J1(n));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[I2,J2] = find(plansza==healthy_protecting_others);
liczbadwa = length(I2);


for n=1:liczbadwa
    planszaZwrotna(I2(n),J2(n)) = plansza(I2(n),J2(n));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[I4,J4] = find(plansza==healthy_no_sec_measures);
liczbacztery = length(I4);


for n=1:liczbacztery
    planszaZwrotna(I4(n),J4(n)) = plansza(I4(n),J4(n));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[I5,J5] = find(plansza==healthy_organising_protection);
liczbapiec = length(I5);


for n=1:liczbapiec
    planszaZwrotna(I5(n),J5(n)) = plansza(I5(n),J5(n));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[I8,J8] = find(plansza==sick_no_symptoms_no_sec_measures);
liczbaosiem = length(I8);


for n=1:liczbaosiem
    planszaZwrotna(I8(n),J8(n)) = plansza(I8(n),J8(n));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[I9,J9] = find(plansza==sick_no_symptoms_infecting);
liczbadziewiec = length(I9);


for n=1:liczbadziewiec
    planszaZwrotna(I9(n),J9(n)) = plansza(I9(n),J9(n));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end