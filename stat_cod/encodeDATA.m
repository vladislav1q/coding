%HERE IS LZ-78 ENCODING ALGORITM



function [encoded, parameters] = encodeDATA(data)
    max_len = 2;
    data = dec2bin(data,8);
    data = char(strjoin(string(data),''));
    
    encoded = [];
    parameters = [];
    words = [''];
    str = '';
    last_word_flag = 0;
    last_word = '';
    phrase_len = 8 + max_len;
    
    for i = 1:(length(data)/8)
        str = str + string(data(8*i-7:8*i));
        
        if(~ismember(str, words))
            words = [words, str];
            word = char(str);
            word_len = length(word);
            
            if(word_len==8)
                phrase = strcat(dec2bin(0,max_len), word(1:8));
                encoded = [encoded, phrase];
            else
                pos = find(ismember(words, word(1:word_len-8)));
                phrase = strcat(dec2bin(pos-1,max_len), (word(word_len-7:word_len)));
                encoded = [encoded, phrase];
            end
            % Dictionary overflow
            if(length(words)-1==2^max_len)
                words = [''];
            end
            str = '';
            
        elseif(i == length(data)/8)
            last_word = str;
            last_word_flag = 1;
        end
    end
    
    words = words(2:end);
    
    if(last_word_flag == 1)
        word = char(last_word);
        if(length(word)==8)
            str = strcat(dec2bin(0,max_len), word(length(word)-7:length(word)));
            encoded = [encoded, str];
        else
            pos = find(ismember(words, word(1:length(word)-8)));
            str = strcat(dec2bin(pos,max_len), (word(length(word)-7:length(word))));
            encoded = [encoded, str];
        end
    end
    %add 'end of encoding' symbol
    encoded = [encoded, dec2bin(2^phrase_len-1,phrase_len)];
end
