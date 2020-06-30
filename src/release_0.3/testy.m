function [result] = testy(person)

sick_symptoms_no_sec_measures=1;
sick_no_symptoms_no_sec_measures=8;
sick_no_symptoms_infecting=9;
sick_symptoms_infecting=10;
sick_symptoms_self_protecting=11;

if person==sick_symptoms_no_sec_measures || person==sick_no_symptoms_no_sec_measures || person==sick_no_symptoms_infecting || person==sick_symptoms_infecting || person==sick_symptoms_self_protecting
    result=1;
else 
    result=0;
end

end

