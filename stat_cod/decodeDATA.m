%HERE IS LZ-78 DECODING ALGORITM

function decoded = decodeDATA(encoded_data, encoded_parameters)
    max_len = 2;
    encoded_data = char(encoded_data);
    decoded = "";
    words = [];
    phrase = "";
    phrase_len = 8 + max_len;
    
    for i = 1:(length(encoded_data)/phrase_len)
        phrase = encoded_data(i*phrase_len-phrase_len+1:i*phrase_len);
        ptr = bin2dec(phrase(1:max_len));
        symb = string(char(bin2dec(phrase(max_len+1:phrase_len))));
        
        if(ptr == 2^max_len-1 && symb == string(char(2^8-1)))
            fprintf("Sucessfully decoded.\n");
            return
        end
        if(ptr == 0)
            words = [words, symb];
            decoded = decoded + symb;
        else
            new_word = words(ptr) + symb;
            decoded = decoded + new_word;
            words = [words, new_word];
        end
        % Dictionary overflow
        if(length(words)==2^max_len)
            words = [];
        end
    end
end

