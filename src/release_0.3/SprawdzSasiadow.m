 % sąsiedztwo Moore'a


function [healthy_self_protection_neighbors,sick_symptoms_no_sec_measures_neighbors, healthy_protecting_others_neighbors,recovered_protecting_others_neighbors,healthy_no_sec_measures_neighbors,healthy_organising_protection_neighbors,in_quarantine_self_protecting_neighbors,in_quarantine_no_sec_measures_neighbors,sick_no_symptoms_no_sec_measures_neighbors,sick_no_symptoms_infecting_neighbors,sick_symptoms_infecting_neighbors,sick_symptoms_self_protecting_neighbors,in_hospital_neighbors,recovered_organising_protection_neighbors,dead_neighbors,recovered_neighbors] = SprawdzSasiadow(plansza,x,y)
    healthy_self_protection_sum=0;
    sick_symptoms_no_sec_measures_sum = 0;
    healthy_protecting_others_sum=0;
    recovered_protecting_others_sum=0;
    healthy_no_sec_measures_sum=0;
    healthy_organising_protection_sum=0;
    in_quarantine_self_protecting_sum=0;
    in_quarantine_no_sec_measures_sum=0;
    sick_no_symptoms_no_sec_measures_sum=0;
    sick_no_symptoms_infecting_sum=0;
    sick_symptoms_infecting_sum=0;
    sick_symptoms_self_protecting_sum=0;
    in_hospital_sum=0;
    recovered_organising_protection_sum=0;
    dead_sum=0;
    recovered_sum=0;
    
    
    [w,k] = size(plansza);
    
    if x>1 
        if plansza(x-1,y)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
        end
        if plansza(x-1,y)==1
            sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
            if plansza(x-1,y)==2
            healthy_protecting_others_sum = healthy_protecting_others_sum+1;        
            end
            if plansza(x-1,y)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
            end
            if plansza(x-1,y)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
            end
            if plansza(x-1,y)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
            end
            if plansza(x-1,y)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
            end
            if plansza(x-1,y)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
            end
            if plansza(x-1,y)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
            end
            if plansza(x-1,y)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
            end
            if plansza(x-1,y)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
            end
            if plansza(x-1,y)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
            end
            if plansza(x-1,y)==12
            in_hospital_sum=in_hospital_sum+1;
            end
            if plansza(x-1,y)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
            end
            if plansza(x-1,y)==14
             dead_sum=dead_sum+1;
            end
            if plansza(x-1,y)==15
             recovered_sum=recovered_sum+1;
            end
           
            
    end
    if y>1
         if plansza(x,y-1)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
         end
        if plansza(x,y-1)==1
           sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
        if plansza(x,y-1)==2
           healthy_protecting_others_sum = healthy_protecting_others_sum+1;
        end
        if plansza(x,y-1)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
        end
        if plansza(x,y-1)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
        end
        if plansza(x,y-1)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
        end
        if plansza(x,y-1)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
        end
         if plansza(x,y-1)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
         end
         if plansza(x,y-1)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
         end
         if plansza(x,y-1)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
         end
         if plansza(x,y-1)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
         end
         if plansza(x,y-1)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
         end
          if plansza(x,y-1)==12
            in_hospital_sum=in_hospital_sum+1;
          end
          if plansza(x,y-1)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
          end
          if plansza(x,y-1)==14
             dead_sum=dead_sum+1;
          end
            if plansza(x,y-1)==15
             recovered_sum=recovered_sum+1;
            end
       
    end
    if x<w  
        if plansza(x+1,y)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
         end
        if plansza(x+1,y)==1
            sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
            if plansza(x+1,y)==2
           healthy_protecting_others_sum = healthy_protecting_others_sum+1; 
            end
         if plansza(x+1,y)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
         end
         if plansza(x+1,y)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
         end
         if plansza(x+1,y)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
         end
         if plansza(x+1,y)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
         end
         if plansza(x+1,y)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
         end
         if plansza(x+1,y)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
         end
         if plansza(x+1,y)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
         end
         if plansza(x+1,y)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
         end
         if plansza(x+1,y)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
         end
          if plansza(x+1,y)==12
            in_hospital_sum=in_hospital_sum+1;
          end
          if plansza(x+1,y)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
          end
          if plansza(x+1,y)==14
             dead_sum=dead_sum+1;
          end
          if plansza(x+1,y)==15
             recovered_sum=recovered_sum+1;
           end
    end
    if y<k 
         if plansza(x,y+1)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
         end
        if plansza(x,y+1)==1
            sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
          if plansza(x,y+1)==2
           healthy_protecting_others_sum = healthy_protecting_others_sum+1;      
          end
          if plansza(x,y+1)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
          end
          if plansza(x,y+1)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
          end
          if plansza(x,y+1)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
          end
          if plansza(x,y+1)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
          end
          if plansza(x,y+1)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
          end
          if plansza(x,y+1)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
          end
         if plansza(x,y+1)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
         end
         if plansza(x,y+1)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
         end
         if plansza(x,y+1)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
         end
          if plansza(x,y+1)==12
            in_hospital_sum=in_hospital_sum+1;
          end
          if plansza(x,y+1)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
          end
          if plansza(x,y+1)==14
             dead_sum=dead_sum+1;
          end
          if plansza(x,y+1)==15
             recovered_sum=recovered_sum+1;
           end
    end
    if x>1 && y>1
        if plansza(x-1,y-1)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
         end
        if plansza(x-1,y-1)==1
            sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
         if plansza(x-1,y-1)==2
           healthy_protecting_others_sum = healthy_protecting_others_sum+1;
         end
        if plansza(x-1,y-1)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
        end
         if plansza(x-1,y-1)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
         end
          if plansza(x-1,y-1)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
          end
          if plansza(x-1,y-1)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
          end
          if plansza(x-1,y-1)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
          end
          if plansza(x-1,y-1)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
          end
          if plansza(x-1,y-1)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
          end
         if plansza(x-1,y-1)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
         end
         if plansza(x-1,y-1)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
         end
          if plansza(x-1,y-1)==12
            in_hospital_sum=in_hospital_sum+1;
          end
          if plansza(x-1,y-1)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
          end
          if plansza(x-1,y-1)==14
             dead_sum=dead_sum+1;
          end
          if plansza(x-1,y-1)==15
             recovered_sum=recovered_sum+1;
           end
    end
    if x>1 && y<k 
         if plansza(x-1,y+1)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
         end
        if plansza(x-1,y+1)==1
            sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
         if plansza(x-1,y+1)==2
           healthy_protecting_others_sum = healthy_protecting_others_sum+1;
         end
         if plansza(x-1,y+1)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
         end
         if plansza(x-1,y+1)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
         end
          if plansza(x-1,y+1)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
          end
          if plansza(x-1,y+1)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
          end
          if plansza(x-1,y+1)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
          end
          if plansza(x-1,y+1)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
          end
          if plansza(x-1,y+1)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
          end
         if plansza(x-1,y+1)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
         end
         if plansza(x-1,y+1)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
         end
          if plansza(x-1,y+1)==12
            in_hospital_sum=in_hospital_sum+1;
          end
          if plansza(x-1,y+1)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
          end
          if plansza(x-1,y+1)==14
             dead_sum=dead_sum+1;
          end
          if plansza(x-1,y+1)==15
             recovered_sum=recovered_sum+1;
           end
    end
    if x<w && y>1 
        if plansza(x+1,y-1)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
         end
        if plansza(x+1,y-1)==1
            sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
             if plansza(x+1,y-1)==2
           healthy_protecting_others_sum = healthy_protecting_others_sum+1;
             end
         if plansza(x+1,y-1)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
         end
         if plansza(x+1,y-1)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
         end
          if plansza(x+1,y-1)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
          end
          if plansza(x+1,y-1)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
          end
          if plansza(x+1,y-1)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
          end
          if plansza(x+1,y-1)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
          end
          if plansza(x+1,y-1)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
          end
         if plansza(x+1,y-1)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
         end
         if plansza(x+1,y-1)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
         end
          if plansza(x+1,y-1)==12
            in_hospital_sum=in_hospital_sum+1;
          end
          if plansza(x+1,y-1)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
          end
          if plansza(x+1,y-1)==14
             dead_sum=dead_sum+1;
          end
          if plansza(x+1,y-1)==15
             recovered_sum=recovered_sum+1;
           end
    end
    if x<w && y<k 
        if plansza(x+1,y+1)==0
            healthy_self_protection_sum = healthy_self_protection_sum+1;
         end
        if plansza(x+1,y+1)==1
           sick_symptoms_no_sec_measures_sum = sick_symptoms_no_sec_measures_sum+1;
        end
        if plansza(x+1,y+1)==2
           healthy_protecting_others_sum = healthy_protecting_others_sum+1;
        end
         if plansza(x+1,y+1)==3
                recovered_protecting_others_sum=recovered_protecting_others_sum+1;
         end
          if plansza(x+1,y+1)==4
                healthy_no_sec_measures_sum=healthy_no_sec_measures_sum+1;
          end
         if plansza(x+1,y+1)==5
                healthy_organising_protection_sum=healthy_organising_protection_sum+1;
         end
          if plansza(x+1,y+1)==6
                in_quarantine_self_protecting_sum=in_quarantine_self_protecting_sum+1;
          end
          if plansza(x+1,y+1)==7
                in_quarantine_no_sec_measures_sum=in_quarantine_no_sec_measures_sum+1;
          end
          if plansza(x+1,y+1)==8
                sick_no_symptoms_no_sec_measures_sum=sick_no_symptoms_no_sec_measures_sum+1;
          end
          if plansza(x+1,y+1)==9
                sick_no_symptoms_infecting_sum=sick_no_symptoms_infecting_sum+1;
          end
         if plansza(x+1,y+1)==10
            sick_symptoms_infecting_sum = sick_symptoms_infecting_sum+1;
         end
         if plansza(x+1,y+1)==11
            sick_symptoms_self_protecting_sum=sick_symptoms_self_protecting_sum+1;
         end
          if plansza(x+1,y+1)==12
            in_hospital_sum=in_hospital_sum+1;
          end
          if plansza(x+1,y+1)==13
             recovered_organising_protection_sum= recovered_organising_protection_sum+1;
          end
          if plansza(x+1,y+1)==14
             dead_sum=dead_sum+1;
          end
          if plansza(x+1,y+1)==15
             recovered_sum=recovered_sum+1;
           end
    end
    
sick_symptoms_no_sec_measures_neighbors = sick_symptoms_no_sec_measures_sum;    
healthy_protecting_others_neighbors = healthy_protecting_others_sum;
recovered_protecting_others_neighbors=recovered_protecting_others_sum; 
healthy_self_protection_neighbors=healthy_self_protection_sum;
healthy_no_sec_measures_neighbors=healthy_no_sec_measures_sum;
healthy_organising_protection_neighbors=healthy_organising_protection_sum;
in_quarantine_self_protecting_neighbors=in_quarantine_self_protecting_sum;
in_quarantine_no_sec_measures_neighbors=in_quarantine_no_sec_measures_sum;
sick_no_symptoms_no_sec_measures_neighbors=sick_no_symptoms_no_sec_measures_sum;
sick_no_symptoms_infecting_neighbors=sick_no_symptoms_infecting_sum;
sick_symptoms_infecting_neighbors=sick_symptoms_infecting_sum;
sick_symptoms_self_protecting_neighbors=sick_symptoms_self_protecting_sum;
in_hospital_neighbors=in_hospital_sum;
recovered_organising_protection_neighbors=recovered_organising_protection_sum;
dead_neighbors=dead_sum;
recovered_neighbors=recovered_sum;

end
  