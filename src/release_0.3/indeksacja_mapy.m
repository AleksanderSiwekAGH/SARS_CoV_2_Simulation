clear all;
close all;

indeks = imread('states_square.jpg');
indeks1 = im2bw(indeks,240/255);
imshow(indeks1,[]);
[indeksacja2, n2] = bwlabel(indeks1, 8);
[a,b] = size(indeksacja2);

zuc = 0;
list = zeros(1,n2);

for x=1:a
    for y=1:b
        for elem=1:n2
            if indeksacja2(x,y) == elem
                list(elem) = list(elem) + 1;
            end
        end
    end
end
   
for w=1:a
    for z=1:b
        for elem2=1:n2
            if indeksacja2(w,z) == elem2
                if list(elem2) < 40
                    indeksacja2(w,z) = 0;
                end
            end
        end
    end
end

[indeksacja3, n3] = bwlabel(indeksacja2, 8);
[a2,b2] = size(indeksacja3);

for wys=1:a2
    for szer=1:b2
            if indeksacja3(wys,szer) == 26
                indeksacja3(wys, szer) = 31;
            end
            if indeksacja3(wys,szer) == 41
                indeksacja3(wys,szer) = 42;
            end
            if indeksacja3(wys,szer) == 45
                indeksacja3(wys,szer) = 43;
            end
    end
    
end


%test
for wys2=1:a2
    for szer2=1:b2
            if indeksacja3(wys2,szer2) == 49
                indeksacja3(wys2, szer2) = 255;
            end
            if indeksacja3(wys2,szer2) == 48
                indeksacja3(wys2, szer2) = 255;
            end
            if indeksacja3(wys2,szer2) == 1
                indeksacja3(wys2, szer2) = 255;
            end
            if indeksacja3(wys2,szer2) == 4
                indeksacja3(wys2, szer2) = 255;
            end
            if indeksacja3(wys2,szer2) == 32
                indeksacja3(wys2, szer2) = 255;
            end
            if indeksacja3(wys2,szer2) == 31
                indeksacja3(wys2, szer2) = 255;
            end
    end
end

figure(1);
imshow(indeksacja3, []);

