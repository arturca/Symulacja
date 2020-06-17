 %input - macierz punktów w losowej kolejnoœci - (n*3) 
function [out] = komiwojazer(input)
input = [0 1 3;10 10 10;2 2 2; 5 5 5; 1 3 7];
points = [[0 0 0]; input]; %dodanie punktu startowego (0,0,0)
[X Y] = size(points);
if Y ~= 3
        error( 'Niew³aœciwy wymiar punktów' );
end
LB = zeros(100,1);
koszt = zeros(100,X,X);    
for i=1:X
    for j = 1:X
        if i==j
           koszt(1,i,j)=Inf;
        else
           koszt(1,i,j) = sqrt((points(i,1)-points(j,1))^2+(points(i,2)-points(j,2))^2+(points(i,1)-points(j,1))^2);
        end
    end
end
sciezka = zeros(X,X);
% odwiedzone = zeros(X,1);
% odwiedzone(1) = 1;
iter = 0;
stop = 0;
while(~stop)
    iter = iter + 1;
    %minimum w wierszach
    perm = permute(koszt, [1 3 2]);
    perm_it = reshape(perm(iter,:,:),X,X);
    minr = min(perm_it);
    for i=1:length(minr)
        if(minr(i)==Inf)
            minr(i) = 0;
        end
    end
    LB(iter) = LB(iter)+sum(minr);
    %redukcja
    for i = 1:X
        for j = 1:X
            koszt(iter,i,j) = koszt(iter,i,j)-minr(i);
        end
    end

    %minimum w kolumnach
    minim = reshape(koszt(iter,:,:),X,X);
    minc = min(minim);
    for i=1:length(minc)
        if(minc(i)==Inf)
            minc(i) = 0;
        end
    end
    LB(iter) = LB(iter)+sum(minc);        
    %redukcja
    for i = 1:X
        for j = 1:X
            koszt(iter,i,j) = koszt(iter,i,j)-minc(j);
        end
    end

    %wyznaczenie najmniejeszej wartoœci z wierszów oprócz 0 niezale¿nego
    minr2=Inf.*ones(X,3);    
    for i = 1:X
        counter = 0;
        for j = 1:X
            if(koszt(iter,i,j)<minr2(i,1) && koszt(iter,i,j)>0)
                minr2(i,:) = [koszt(iter,i,j) i j];
            elseif (koszt(iter,i,j)==0 && counter>0)
                minr2(i,:)=[0 i j];
            elseif (koszt(iter,i,j)==0 && counter==0)
                counter = counter + 1;
            end
        end
    end

    %wyznaczenie najmniejszej wartoœci z kolumn oprócz 0 niezale¿nego
    minc2=Inf.*ones(X,3);
    for j = 1:X
        counter = 0;
        for i = 1:X            
            if(koszt(iter,i,j)<minc2(j,1) && koszt(i,j)>0)
                minc2(j,:) = [koszt(iter,i,j) i j];
            elseif (koszt(iter,i,j)==0 && counter>0)
                minc2(j,:)=[0 i j];
            elseif (koszt(iter,i,j)==0 && counter==0)
                counter = counter + 1;
            end
        end
    end

    %wyznaczenie wiersza i kolmny z najwieksza sum¹ wartoœci minimalnych w
    %rzedzie i kolumnie dla zer
    tempmax = 0;
    minrc = zeros(X,X);
    for i = 1:X
        for j = 1:X
            minrc(i,j) = minr2(i,1) + minc2(j,1);
            if (koszt(iter,i,j) == 0 && minrc(i,j)>tempmax)
%                 git = true; %git
%                 for z = 1:length(odwiedzone)
%                     if k== odwiedzone(z) %sprawdzmay czy nie ma podcyklu
%                         git = false; %nie git
%                     end
%                 end
%                 if (git)  %jeœli git                
                    tempmax = minrc(i,j);
                    w = i;
                    k = j;
%                     odwiedzone(iter+1)= k;
%                   end
            end
        end
    end
    
    %dodanie do sciezki
    sciezka(w,k)  = 1;
    %zaktualizowanie dolnego ograniczenia
    LB(iter+1) = LB(iter);
    LB(iter) = LB(iter) + tempmax;
    koszt(iter+1,:,:) = koszt(iter,:,:);
    %zablokowanie przejœæ:
    koszt(iter+1,w,:) = ones(X,1).*Inf; 
    koszt(iter+1,:,k) = ones(X,1).*Inf;
    koszt(iter+1,k,w) = Inf;
    counter2 = 0;
    for i = 1:X
        for j = 1:X
            if (koszt(iter+1,i,j)<Inf)
                counter2 = counter2+1;
            end
        end
    end
    %ilosc elementów !=Inf
    if (counter2<=4)
        stop = 1;
        iter = iter + 1;
        %minimum w wierszach
        perm = permute(koszt, [1 3 2]);
        perm_it = reshape(perm(iter,:,:),X,X);
        minr = min(perm_it);
        for i=1:length(minr)
            if(minr(i)==Inf)
                minr(i) = 0;
            end
        end
        %redukcja
        for i = 1:X
            for j = 1:X
                koszt(iter,i,j) = koszt(iter,i,j)-minr(i);
            end
        end
        %minimum w kolumnach
        minim = reshape(koszt(iter,:,:),X,X);
        minc = min(minim);
        for i=1:length(minc)
            if(minc(i)==Inf)
                minc(i) = 0;
            end
        end
        LB(iter) = LB(iter)+sum(minc);        
        %redukcja
        for i = 1:X
            for j = 1:X
                koszt(iter,i,j) = koszt(iter,i,j)-minc(j);
            end
        end
        
        %wybór œcie¿ki z maceirzy 2x2
        wiersz = [0 0 0 0];
        kolumna = [0 0 0 0];
        it = 0;
        for i = 1:X
            for j = 1:X
                if (koszt(iter,i,j)<Inf)
                    it = it + 1;
                    wiersz(it) = i;
                    kolumna(it) = j;
                end
            end
        end
        powtw = [0 0 0 0];
        powtk = [0 0 0 0];
        for i = 1:length(wiersz)-1
            for j = 1:length(wiersz)-1
                if wiersz(i)==wiersz(j) && wiersz(i)~=0
                    powtw(i) = powtw(i) + 1;
                end
                if kolumna(i) == kolumna(j) && kolumna(i)~=0
                    powtk(i) = powtk(i) + 1;
                end
            end
        end
        for i = 1:length(powtw)
            if powtw(i) == 1
                w=wiersz(i);
            end
            if powtk(i) == 1
                k=kolumna(i);
            end
        end
        sciezka(w,k) = 1;
        for i=1:length(wiersz)
            if wiersz(i) ~= 0 && wiersz(i)~=w
                w2 = wiersz(i);
            end
            if kolumna(i) ~= 0 && kolumna(i)~=k
                k2 = kolumna(i);
            end
        end
        sciezka(w2,k2) = 1;
    end     
end

%wyznaczenie trasy
out_s =  zeros(X,1);
out_s(1) = 1;
for i=1:X
    j=out_s(i);
    for k=1:X
        if sciezka(j,k) == 1
            out_s(i+1) = k;
        end
    end
end

%wyjœcie
output = zeros(X+1,Y);
for i=1:X
    output(i,:) = points(out_s(i),:);
end
out = output;    
      
end