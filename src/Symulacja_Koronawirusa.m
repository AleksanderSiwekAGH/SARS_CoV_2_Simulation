function [] = Symulacja_Koronawirusa(app)



rozmiar = app.SizeEditAustralia.Value; % rozmiar planszy
stan = zeros(rozmiar,rozmiar);  % biezacy stan

liczba_dni = app.DaysEditAustralia.Value;   %ile dni uplynelo od początku pandemii (25 styczen - 30 kwiecien)

healthy_self_protection=0;
sick_symptoms_no_sec_measures=1;
healthy_protecting_others=2;
recovered_protecting_others=3;
healthy_no_sec_measures=4;
healthy_organising_protection=5;
in_quarantine_self_protecting=6;
in_quarantine_no_sec_measures=7;
sick_no_symptoms_no_sec_measures=8;
sick_no_symptoms_infecting=9;
sick_symptoms_infecting=10;
sick_symptoms_self_protecting=11;
in_hospital=12;
recovered_organising_protection=13;
dead=14;
recovered=15;


% wczytanie początkowego stadium epidemii z pliku:
stan=pokazstan(stan,'start.txt',0,0);

 %[fileID,message] = fopen('rezultat.txt','w');
for n=1:liczba_dni

    %1

    % znajduje wszystkie rodzaje stanów  
    [A0,B0]=find(stan==healthy_self_protection);
    [A1,B1]=find(stan==sick_symptoms_no_sec_measures);
    [A2,B2]=find(stan==healthy_protecting_others);
    [A3,B3]=find(stan==recovered_protecting_others);
    [A4,B4]=find(stan==healthy_no_sec_measures);
    [A5,B5]=find(stan==healthy_organising_protection);
    [A6,B6]=find(stan==in_quarantine_self_protecting);
    [A7,B7]=find(stan==in_quarantine_no_sec_measures);
    [A8,B8]=find(stan==sick_no_symptoms_no_sec_measures);
    [A9,B9]=find(stan==sick_no_symptoms_infecting);
    [A10,B10]=find(stan==sick_symptoms_infecting);
    [A11,B11]=find(stan==sick_symptoms_self_protecting);
    [A12,B12]=find(stan==in_hospital);
    [A13,B13]=find(stan==recovered_organising_protection);
    [A14,B14]=find(stan==dead);
    [A15,B15]=find(stan==recovered);
    %figure(1)
    hold(app.AxesAustralia, 'off');
    
    hold(app.AxesAustralia, 'on');
    plot(B0,rozmiar-A0,'.','Marker', 's', 'Color', '#e8deae', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B1,rozmiar-A1,'.','Marker', 's', 'Color', 'm', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B2,rozmiar-A2,'.','Marker', 's', 'Color', '#a5dde8', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B3,rozmiar-A3,'.','Marker', 's', 'Color', '#77AC30', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B4,rozmiar-A4,'.','Marker', 's', 'Color', '#ebc3dd', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B5,rozmiar-A5,'.','Marker', 's', 'Color', '#b8decc', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B6,rozmiar-A6,'.','Marker', 's', 'Color', '#0072BD', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B7,rozmiar-A7,'.','Marker', 's', 'Color', '#4DBEEE', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B8,rozmiar-A8,'.','Marker', 's', 'Color', '#EDB120', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B9,rozmiar-A9,'.','Marker', 's', 'Color', '#D95319', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B10,rozmiar-A10,'.','Marker', 's', 'Color', 'r', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B11,rozmiar-A11,'.','Marker', 's', 'Color', '#bd7164', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B12,rozmiar-A12,'.','Marker', 's', 'Color', 'b', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B13,rozmiar-A13,'.','Marker', 's', 'Color', '#3b7d46', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B14,rozmiar-A14,'.','Marker', 's', 'Color', 'k', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
    plot(B15,rozmiar-A15,'.','Marker', 's', 'Color', 'g', 'MarkerSize', 5,'Parent', app.AxesAustralia);
    hold(app.AxesAustralia, 'on');
   
    axis([1 rozmiar 1 rozmiar]);
    daspect([1,1,1])
    
    %ktory to dzień:
    title(['cykl ', num2str(n)],'Parent',app.AxesAustralia);
    %zmienne pomocnicze do obliczania ilości testów
    liczba_testow=0;   
    liczba_testow_pozytywnych=0;
    liczba_wyzdrowialych=0;
    %2
    
   
    kolejny_stan=zeros(rozmiar,rozmiar);
    for w=1:rozmiar
        for k=1:rozmiar
           [healthy_self_protection_neighbors,sick_symptoms_no_sec_measures_neighbors, healthy_protecting_others_neighbors,recovered_protecting_others_neighbors,healthy_no_sec_measures_neighbors,healthy_organising_protection_neighbors,in_quarantine_self_protecting_neighbors,in_quarantine_no_sec_measures_neighbors,sick_no_symptoms_no_sec_measures_neighbors,sick_no_symptoms_infecting_neighbors,sick_symptoms_infecting_neighbors,sick_symptoms_self_protecting_neighbors,in_hospital_neighbors,recovered_organising_protection_neighbors,dead_neighbors,recovered_neighbors] = SprawdzSasiadow(stan,w,k);

% 
  % fprintf(fileID, '%d ,',stan(w,k));
% 

    
%%%%%%%%%%%%%%%ZACHOROWANIA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        
            if stan(w,k)==healthy_no_sec_measures
                if sick_no_symptoms_infecting_neighbors>=1 && sick_no_symptoms_infecting_neighbors<=8
                        if recovered_protecting_others_neighbors<3
                           kolejny_stan(w,k)=sick_no_symptoms_infecting;
                end
               end
             end
           
       
        
        
       
            if stan(w,k)==healthy_organising_protection
                if sick_no_symptoms_infecting_neighbors>=1 && sick_no_symptoms_infecting_neighbors<=8
                       if recovered_protecting_others_neighbors<3
                   kolejny_stan(w,k)=sick_no_symptoms_infecting;
                end
               end
             end
         
        
          
        
        
         
             if stan(w,k)==healthy_protecting_others
              if (sick_no_symptoms_infecting_neighbors>=3 && sick_no_symptoms_infecting_neighbors<=8) || (sick_no_symptoms_no_sec_measures_neighbors>=3 && sick_no_symptoms_no_sec_measures_neighbors<=8)
                     if recovered_protecting_others_neighbors<2
                  kolejny_stan(w,k)=sick_no_symptoms_infecting;
                 end
                 end
                end
          
        
         
         
             if stan(w,k)==healthy_protecting_others
              if (sick_no_symptoms_infecting_neighbors>=3 && sick_no_symptoms_infecting_neighbors<=8) || (sick_no_symptoms_no_sec_measures_neighbors>=2 && sick_no_symptoms_no_sec_measures_neighbors<=8)
                     if recovered_protecting_others_neighbors<2
                  kolejny_stan(w,k)=sick_no_symptoms_no_sec_measures;
                 end
              end
             end
         
          
          
             if stan(w,k)==healthy_no_sec_measures
              if (sick_no_symptoms_infecting_neighbors>=2 && sick_no_symptoms_infecting_neighbors<=8) || (sick_no_symptoms_no_sec_measures_neighbors>=2 && sick_no_symptoms_no_sec_measures_neighbors<=8)
                     if recovered_protecting_others_neighbors<2
                  kolejny_stan(w,k)=sick_no_symptoms_no_sec_measures;
                 end
                 end
                end

          
         
          
             if stan(w,k)==healthy_no_sec_measures
              if (sick_no_symptoms_infecting_neighbors>=2 && sick_no_symptoms_infecting_neighbors<=8) || (sick_no_symptoms_no_sec_measures_neighbors>=2 && sick_no_symptoms_no_sec_measures_neighbors<=8)
                     if recovered_protecting_others_neighbors<2
                  kolejny_stan(w,k)=sick_symptoms_no_sec_measures;
                 end
                 end
                end
          
       

         
             if stan(w,k)==healthy_organising_protection
              if (sick_no_symptoms_infecting_neighbors>=3 && sick_no_symptoms_infecting_neighbors<=8) || (sick_no_symptoms_no_sec_measures_neighbors>=2 && sick_no_symptoms_no_sec_measures_neighbors<=8)
                     if recovered_protecting_others_neighbors<2
                  kolejny_stan(w,k)=sick_no_symptoms_no_sec_measures;
                 end
              end
             end
          

 
          
             if stan(w,k)==healthy_no_sec_measures
              if (sick_symptoms_infecting_neighbors>=2 && sick_no_symptoms_infecting_neighbors<=8) || (sick_symptoms_no_sec_measures_neighbors>=2 && sick_symptoms_no_sec_measures_neighbors<=8)
                     if recovered_protecting_others_neighbors<2
                  kolejny_stan(w,k)=sick_symptoms_no_sec_measures;
                 end
                 end
                end
      
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%prawdopodobienstwo przejscia ze stanu no_symptoms do symptoms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
          prob_symptoms=0;
            if stan(w,k)==sick_no_symptoms_no_sec_measures || stan(w,k)==sick_no_symptoms_infecting
                g=n;
                if mod(g,2)==0
                    prob_symptoms=prob_symptoms+1;
                end    
                if mod(g,3)==0
                    prob_symptoms=prob_symptoms+2;
                end
                if mod(g,4)==0
                    prob_symptoms=prob_symptoms+3;
                end
                if mod(g,5)==0
                    prob_symptoms=prob_symptoms+4;
                end
            end
            
		    num=ceil(rand(1)*50);   
            if stan(w,k)==sick_no_symptoms_no_sec_measures
                if num< prob_symptoms
                    kolejny_stan(w,k) = sick_symptoms_no_sec_measures;
                else
			     kolejny_stan(w,k)=sick_no_symptoms_no_sec_measures;
                end
            end
            
          if stan(w,k)==sick_no_symptoms_infecting
            if (num-5)< prob_symptoms
                kolejny_stan(w,k) = sick_symptoms_infecting;
            else
                kolejny_stan(w,k)=sick_no_symptoms_infecting;
            end
          end 
            
            %%%%zmiana zachowania z gorszego, na lepsze -
            %%%%prawdopodobienstwo mniejsze
            num1=ceil(rand(1)*100);   
         if stan(w,k)==sick_no_symptoms_no_sec_measures
            if (num1 - 1)< prob_symptoms
                kolejny_stan(w,k) = sick_symptoms_self_protecting;  
            else
                kolejny_stan(w,k)=sick_no_symptoms_no_sec_measures;
            end 
         end 
     

    
         %%%%Prawdopodobieńwto oraz przejście do stanu in_hospital%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

           prob_of_going_to_hospital=0;
           prob_hos=0;
          if stan(w,k)==sick_symptoms_no_sec_measures ||stan(w,k)==sick_no_symptoms_infecting || stan(w,k)==sick_symptoms_infecting ||stan(w,k)==sick_no_symptoms_no_sec_measures ||stan(w,k)==sick_symptoms_self_protecting
             m=n;
                if mod(m,10)==0
                    prob_hos=prob_hos+10; 
                end
          end
        mnoznik=ceil(rand(1)*15);
		prob_of_going_to_hospital=mnoznik*(prob_of_going_to_hospital + ceil(healthy_protecting_others_neighbors*0.5)...
            +recovered_protecting_others_neighbors+prob_hos);
        num2=ceil(rand(1)*2000);
        
            if stan(w,k)==sick_symptoms_no_sec_measures 
                if prob_of_going_to_hospital>num2
                    kolejny_stan(w,k)=in_hospital;   
                else 
                    kolejny_stan(w,k)=sick_symptoms_no_sec_measures;
                   
                end
            end
        
    
        
            if stan(w,k)==sick_symptoms_infecting
                if prob_of_going_to_hospital>num2
                    kolejny_stan(w,k)=in_hospital;   
                else 
                    kolejny_stan(w,k)=sick_symptoms_infecting;
                    
                end
            end
        
        

        
        
            if stan(w,k)==sick_symptoms_self_protecting 
                if prob_of_going_to_hospital>num2
                    kolejny_stan(w,k)=in_hospital;   
                else 
                    kolejny_stan(w,k)=sick_symptoms_self_protecting;
                   
                end
            end
            
   %%
       %%%%%%%%%%%%%%%%%%%przejscie do stanu wyzdrowienia i
       %%%%%%%%%%%%%%%%%%%prawdopodobienstwo%%%%%%%%%%%%%%%%%%%%%%
       prob_of_recovered=0;
       l=0;
       if stan(w,k)==in_hospital
           l=n;
           prob_of_recovered=prob_of_recovered+4;
           if mod(l,16)==0
               prob_of_recovered=prob_of_recovered+14;
           end
       end
       prob_of_recovered=prob_of_recovered*3;
       num4=ceil(rand(1)*50);
        if stan(w,k)==in_hospital
           if prob_of_recovered>num4
               kolejny_stan(w,k)=recovered;
           else
               kolejny_stan=in_hospital;
           end
        end
       if stan(w,k)==sick_symptoms_no_sec_measures ||stan(w,k)==sick_no_symptoms_infecting|| stan(w,k)== sick_symptoms_infecting ||stan(w,k)==sick_no_symptoms_no_sec_measures ||stan(w,k)==sick_symptoms_self_protecting ||  stan(w,k)==in_quarantine_self_protecting || stan(w,k)==in_quarantine_no_sec_measures
        if prob_of_recovered>num4
               kolejny_stan(w,k)=recovered;
         
        end
       end
       
     
       if stan(w,k)==recovered 
           if healthy_organising_protection_neighbors>=2 && healthy_organising_protection_neighbors<=8
               kolejny_stan(w,k)=recovered_organising_protection;
           end
       end
       
       
       if stan(w,k)==recovered 
           if healthy_protecting_others_neighbors>=2 && healthy_organising_protection_neighbors<=8
               kolejny_stan(w,k)=recovered_protecting_others;
           end
       end
       
      
         if stan(w,k)==recovered_organising_protection
           if recovered_organising_protection_neighbors>=2 && recovered_organising_protection_neighbors<=8
               kolejny_stan(w,k)=recovered_protecting_others;
         end
         end
       
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Prawdopodobieństwa różnych stanów bycia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%zdrowym oraz ich
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%wystąpienie%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%healthy_no_sec_measures%%%%%%%%%%%%%%%%%%%
prob_of_changing=1;
 if healthy_no_sec_measures_neighbors>=2 && healthy_no_sec_measures_neighbors<=8
    prob_of_changing=prob_of_changing+10;
 end
prob_of_changing=prob_of_changing*ceil(rand(1)*50);
num3=rand(1)*30000;
   new_w=ceil(rand(1)*100);
   new_k=ceil(rand(1)*100);
   if stan(new_w,new_k)~=recovered
       if stan(new_w,new_k)~=sick_no_symptoms_no_sec_measures
       if stan(new_w,new_k)~=sick_no_symptoms_infecting
        if stan(new_w,new_k)~=sick_symptoms_infecting
          if stan(new_w,new_k)~=sick_symptoms_self_protecting
        if stan(new_w,new_k)==healthy_self_protection
            if prob_of_changing>num3
                kolejny_stan(new_w,new_k)=healthy_no_sec_measures;
            else
                kolejny_stan(new_w,new_k)=healthy_self_protection;
            end
            end
       end
       end
       end
       end
   end

 %%%%%%%%%%%%%%%%%%%%%%healthy_protecting_others%%%%%%%%%%%%%%%%%%%5      
    prob_of_changing1=1;
 if recovered_protecting_others_neighbors>=3 
     
    prob_of_changing1=prob_of_changing1+30;
 end
prob_of_changing1=prob_of_changing1*ceil(rand(1)*50);

num5=rand(1)*30000;

   new1_w=ceil(rand(1)*100);
   new1_k=ceil(rand(1)*100);
   if stan(new1_w,new1_k)~=recovered
       if stan(new1_w,new1_k)~=sick_no_symptoms_no_sec_measures
       if stan(new1_w,new1_k)~=sick_no_symptoms_infecting
        if stan(new1_w,new1_k)~=sick_symptoms_infecting
          if stan(new1_w,new1_k)~=sick_symptoms_self_protecting
           if stan(new1_w,new1_k)==healthy_self_protection
            if prob_of_changing1>num5
                kolejny_stan(new1_w,new1_k)=healthy_protecting_others;
            else
                kolejny_stan(new1_w,new1_k)=healthy_self_protection;
            end
            end
       end
       end
       end
       end
   end   
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%healthy_organising_protection%%%%%%%%%%%%%%%%%%%5
   
   
    prob_of_changing2=1;
 if recovered_protecting_others_neighbors>=3 
     
    prob_of_changing2=prob_of_changing2+30;
 end
prob_of_changing2=prob_of_changing2*ceil(rand(1)*50);

num6=rand(1)*30000;

   new2_w=ceil(rand(1)*100);
   new2_k=ceil(rand(1)*100);
   if stan(new2_w,new2_k)~=recovered
       if stan(new2_w,new2_k)~=sick_no_symptoms_no_sec_measures
       if stan(new2_w,new2_k)~=sick_no_symptoms_infecting
        if stan(new2_w,new2_k)~=sick_symptoms_infecting
          if stan(new2_w,new2_k)~=sick_symptoms_self_protecting
           if stan(new2_w,new2_k)==healthy_self_protection
            if prob_of_changing1>num5
                kolejny_stan(new2_w,new2_k)=healthy_organising_protection;
            else
                kolejny_stan(new2_w,new2_k)=healthy_self_protection;
            end
           end
         end
       end
       end
       end
   end  
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
   
      
   
    prob_of_changing3=1;
 if recovered_protecting_others_neighbors>=3 
     
    prob_of_changing3=prob_of_changing3+30;
 end
prob_of_changing3=prob_of_changing3*ceil(rand(1)*50);

num7=rand(1)*30000;

   new3_w=ceil(rand(1)*100);
   new3_k=ceil(rand(1)*100);
   if stan(new3_w,new3_k)~=recovered
       if stan(new3_w,new3_k)~=sick_no_symptoms_no_sec_measures
       if stan(new3_w,new3_k)~=sick_no_symptoms_infecting
        if stan(new3_w,new3_k)~=sick_symptoms_infecting
          if stan(new3_w,new3_k)~=sick_symptoms_self_protecting
           if stan(new3_w,new3_k)==healthy_organising_protection
            if prob_of_changing3>num7
                kolejny_stan(new3_w,new3_k)=healthy_protecting_others;
            else
                kolejny_stan(new3_w,new3_k)=healthy_organising_protection;
            end
            end
       end
       end
       end
       end
   end  

   
    prob_of_changing4=1;
 if recovered_protecting_others_neighbors>=3 
     
    prob_of_changing4=prob_of_changing4+30;
 end
prob_of_changing4=prob_of_changing4*ceil(rand(1)*50);

num8=rand(1)*30000;

   new4_w=ceil(rand(1)*100);
   new4_k=ceil(rand(1)*100);
   if stan(new4_w,new4_k)~=recovered
       if stan(new4_w,new4_k)~=sick_no_symptoms_no_sec_measures
       if stan(new4_w,new4_k)~=sick_no_symptoms_infecting
        if stan(new4_w,new4_k)~=sick_symptoms_infecting
          if stan(new4_w,new4_k)~=sick_symptoms_self_protecting
           if stan(new4_w,new4_k)==healthy_organising_protection
            if prob_of_changing4>num8
                kolejny_stan(new4_w,new4_k)=healthy_no_sec_measures;
            else
                kolejny_stan(new4_w,new4_k)=healthy_organising_protection;
            end
            end
       end
       end
       end
       end
   end  
   
  

   if stan(w,k)~=recovered
       if stan(w,k)==healthy_organising_protection
           if healthy_organising_protection_neighbors>=4 && healthy_organising_protection_neighbors<=8
               kolejny_stan(w,k)=healthy_protecting_others;
           end
       end
   end
   
   %%%%%%%%%%%%%%%%%%%%%%%%%Śmierć%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    probability_of_death=1;
   if stan(w,k)~=healthy_no_sec_measures
       if stan(w,k)~= healthy_self_protection
           if stan(w,k)~= healthy_organising_protection
               if stan(w,k)~= healthy_protecting_others
                   if stan(w,k)~=recovered
                       if stan(w,k)~=recovered_protecting_others
                               probability_of_death=1;                
                       if stan(w,k)~= in_hospital && ( stan(w,k)==sick_no_symptoms_no_sec_measures || stan(w,k)==sick_no_symptoms_infecting || stan(w,k)==sick_symptoms_no_sec_measures || stan(w,k)==sick_symptoms_infecting || stan(w,k)==in_quarantine_no_sec_measures)
                            probability_of_death=probability_of_death+19;
                       end
                       if stan(w,k)==in_quarantine_self_protecting
                       probability_of_death=probability_of_death-5;
                       end
                       if stan(w,k)==sick_symptoms_self_protecting
                           probability_of_death=probability_of_death-5;
                       end
   
                   end
               end
           end
       end
      end
   end
  
   
    probability_of_survival=20;
   if stan(w,k)~=recovered
   if stan(w,k)~= dead
    if stan(w,k)~=sick_no_symptoms_no_sec_measures
       if stan(w,k)~= sick_no_symptoms_infecting
           if stan(w,k)~= sick_symptoms_no_sec_measures
               if stan(w,k)~= sick_symptoms_infecting
                  
                   if healthy_protecting_others_neighbors>=1
                    probability_of_survival = probability_of_survival+5;
                   end
                   if   recovered_protecting_others_neighbors>=1
                       probability_of_survival = probability_of_survival+5;
                   end
                   if stan(w,k)==in_hospital 
                       probability_of_survival= probability_of_survival+15;
                   end
                   if stan(w,k)==in_quarantine_self_protecting
                       probability_of_survival= probability_of_survival+5;
                   end
                   if stan(w,k)==sick_symptoms_self_protecting
                          probability_of_survival= probability_of_survival+5;
                   end
               end
           end
       end
    end
   end
   end
   
  
  if healthy_protecting_others_neighbors==0
    if stan(w,k)==sick_no_symptoms_no_sec_measures
       if dead_neighbors==0 
         if probability_of_death>2*probability_of_survival
           kolejny_stan(w,k)=dead;
         end
       end
     end
  end
        
        
   if healthy_protecting_others_neighbors==0
       if stan(w,k)== sick_no_symptoms_infecting
          if dead_neighbors==0 
           if probability_of_death>1.4*probability_of_survival
           
              kolejny_stan(w,k)=dead;
           end
          end
      end
   end
   
   if healthy_protecting_others_neighbors==0
           if stan(w,k)==sick_symptoms_no_sec_measures
               if dead_neighbors==0 
               if probability_of_death>probability_of_survival
           kolejny_stan(w,k)=dead;
       end
           end
     end
   end
          if healthy_protecting_others_neighbors==0
               if stan(w,k)== sick_symptoms_infecting
                   if dead_neighbors==0 
                   if probability_of_death>probability_of_survival
           kolejny_stan(w,k)=dead;
       end
               end
           end
          end
           
           if healthy_protecting_others_neighbors==0
                   if stan(w,k)==sick_symptoms_self_protecting
                       if dead_neighbors==0 
                       if probability_of_death>1.6*probability_of_survival
           kolejny_stan(w,k)=dead;
       end
   end
                   end  
           end
                   
           if healthy_protecting_others_neighbors==0
                   if stan(w,k)==in_quarantine_no_sec_measures
                     if dead_neighbors==0  
                       if probability_of_death>probability_of_survival
                                 kolejny_stan(w,k)=dead;
                    end
                   end
                   end
           end
                   
          if healthy_protecting_others_neighbors==0
                       if stan(w,k)==in_quarantine_self_protecting
                          if dead_neighbors==0  
                           if probability_of_death>1.6*probability_of_survival
                                     kolejny_stan(w,k)=dead;
                           end
                          end
                   end                        
          end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%Pogorszenie sie stanu na kwarantannie%%%%%%%%%%%%%%%%%%%%%%%%%
 prob_worse=ceil(rand(1)*50); 
 num9=ceil(rand(1)*100);   
            if stan(w,k)==in_quarantine_no_sec_measures
                if prob_worse>num9
                    kolejny_stan(w,k) = sick_symptoms_no_sec_measures;
                else
			     kolejny_stan(w,k)=in_quarantine_no_sec_measures;
                end
            end
            
            prob_worse1=ceil(rand(1)*50); 
            num10=ceil(rand(1)*100);   
            if stan(w,k)==in_quarantine_self_protecting
                if prob_worse1>num10
                    kolejny_stan(w,k) = sick_symptoms_self_protecting;
                else
			     kolejny_stan(w,k)=in_quarantine_self_protecting;
                end
            end
 
          
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TESTY%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
                           
if sick_symptoms_no_sec_measures_neighbors>=2  ||  sick_symptoms_infecting_neighbors>=2 ||    sick_symptoms_self_protecting_neighbors>=2    
   [result] = testy(stan(w,k));
   liczba_testow=liczba_testow+1;
   
 if result==1
     liczba_testow_pozytywnych=liczba_testow_pozytywnych+1;
   if stan(w,k)==sick_no_symptoms_no_sec_measures
       kolejny_stan(w,k)=in_quarantine_no_sec_measures;
   end
   
   if stan(w,k)==sick_no_symptoms_infecting
       kolejny_stan(w,k)=in_quarantine_self_protecting;
   end
 
   if stan(w,k)==sick_symptoms_no_sec_measures
       kolejny_stan(w,k)=in_hospital;
   end
   
   if stan(w,k)==sick_symptoms_infecting
       kolejny_stan(w,k)=in_hospital;
   end
   
   if stan(w,k)==sick_symptoms_self_protecting
       kolejny_stan(w,k)=in_hospital;
   end
     

end
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if stan(w,k)==14
    app.numDead.Value=app.numDead.Value+1;
end

if stan(w,k)==3
    app.numRec.Value=app.numRec.Value+1;
end

if stan(w,k)==13
    app.numRec.Value=app.numRec.Value+1;
end

if stan(w,k)==15
    app.numRec.Value=app.numRec.Value+1;
end
   
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
             
      
         end
    end
    app.madeTests.Value=liczba_testow;
    app.positiveTests.Value=liczba_testow_pozytywnych;
    
    
    %3
    [C1,D1] = find(kolejny_stan==sick_symptoms_no_sec_measures);
    liczbajedynek = length(C1);    
     
    m=1;
   
    for m=1:liczbajedynek
        stan(C1(m),D1(m)) = kolejny_stan(C1(m),D1(m));
    end    
   
      
     [C2,D2] = find(kolejny_stan==healthy_protecting_others);
    liczbadwojek = length(C2); 
    
    m=1;
    for m=1:liczbadwojek
        stan(C2(m),D2(m)) = kolejny_stan(C2(m),D2(m));
    end 
    
    [C3,D3] = find(kolejny_stan==recovered_protecting_others);
    liczbatrojek = length(C3); 
   
    m=1;
    for m=1:liczbatrojek
        stan(C3(m),D3(m)) = kolejny_stan(C3(m),D3(m));
    end 
    
    
    
     [C4,D4] = find(kolejny_stan==healthy_no_sec_measures);
    liczbaczworek = length(C4); 
  
    m=1;
    for m=1:liczbaczworek
        stan(C4(m),D4(m)) = kolejny_stan(C4(m),D4(m));
    end 
    
    
    [C5,D5] = find(kolejny_stan==healthy_organising_protection);
    liczbapiatek = length(C5); 
   
    m=1;
    for m=1:liczbapiatek
        stan(C5(m),D5(m)) = kolejny_stan(C5(m),D5(m));
    end 
    
    [C6,D6] = find(kolejny_stan==in_quarantine_self_protecting);
    liczbaszostek = length(C6); 
   
    m=1;
    for m=1:liczbaszostek
        stan(C6(m),D6(m)) = kolejny_stan(C6(m),D6(m));
    end 
    
    
     [C7,D7] = find(kolejny_stan==in_quarantine_no_sec_measures);
    liczbasiodemek = length(C7); 
    
    
    m=1;
    for m=1:liczbasiodemek
        stan(C7(m),D7(m)) = kolejny_stan(C7(m),D7(m));
    end 
    
    
    
     [C8,D8] = find(kolejny_stan==sick_no_symptoms_no_sec_measures);
    liczbaosemek = length(C8); 
    
    m=1;
    for m=1:liczbaosemek
        stan(C8(m),D8(m)) = kolejny_stan(C8(m),D8(m));
    end 
    
    
    [C9,D9] = find(kolejny_stan==sick_no_symptoms_infecting);
    liczbadziewiatek = length(C9); 
    
    
    m=1;
    for m=1:liczbadziewiatek
        stan(C9(m),D9(m)) = kolejny_stan(C9(m),D9(m));
    end 
    
    
    
     [C10,D10] = find(kolejny_stan==sick_symptoms_infecting);
    liczbadziesiatek = length(C10); 
    
    
    m=1;
    for m=1:liczbadziesiatek
        stan(C10(m),D10(m)) = kolejny_stan(C10(m),D10(m));
    end 
    
    
    
    
     [C11,D11] = find(kolejny_stan==sick_symptoms_self_protecting);
    liczbajedenastek = length(C11); 
    
    m=1;
    for m=1:liczbajedenastek
        stan(C11(m),D11(m)) = kolejny_stan(C11(m),D11(m));
    end 
    
    
    [C12,D12] = find(kolejny_stan==in_hospital);
    liczbadwunastek = length(C12);
   
    m=1;
    for m=1:liczbadwunastek
        stan(C12(m),D12(m)) = kolejny_stan(C12(m),D12(m));
    end 
 
    
    
    [C13,D13] = find(kolejny_stan==recovered_organising_protection);
    liczbatrzynastek = length(C13); 
    
 
    m=1;
    for m=1:liczbatrzynastek
        stan(C13(m),D13(m)) = kolejny_stan(C13(m),D13(m));
    end 
    
    
    [C14,D14] = find(kolejny_stan==dead);
    liczbaczternastek = length(C14); 
    
    
    m=1;
    for m=1:liczbaczternastek
        stan(C14(m),D14(m)) = kolejny_stan(C14(m),D14(m));
    end 
    
 
    [C15,D15] = find(kolejny_stan==recovered);
    liczbapietnastek = length(C15); 
    
   
    m=1;
    for m=1:liczbapietnastek
        stan(C15(m),D15(m)) = kolejny_stan(C15(m),D15(m));
    end 
    
   
    
     %tymczasowy warunek wyjscia
    hold off
    if liczbajedynek==10000
        disp('Wszyscy zachorowali:(');
	    [C1,D1] = find(stan);
        plot(D1,rozmiar-C1,'.','Marker', 's', 'Color', 'b', 'MarkerSize', 4,'Parent', app.AxesAustralia);
        break;
    end
    pause(0.05);
  
end

end