clc
clear
%max_len shows the max size of dictionary
%if the encoding is too slow, try to choose bigger value of max_len
max_len = 2;

load('data/4.mat');
[encoded_data, encoded_parameters] = encodeDATA(data);
decoded_data = decodeDATA(encoded_data, encoded_parameters);
disp(data);
disp(encoded_data);
disp(decoded_data);

[alphabet, probabilities] = alphabet_probabilities(data);
fprintf("symbols: ");
fprintf("%c ", alphabet);
fprintf("\nprobabilities: ");
fprintf("%.3f ", probabilities);
fprintf("\n");

fprintf("Zero order symbol entropy: %g bits\n", log2(length(unique(data))));
fprintf("Symbol entropy: %g bits\n", entropy(data));

fprintf("Input stream bit volume: %d bit\n", 8*length(data));

fprintf("Coded data length: %d bits\n", length(encoded_data));
fprintf("Total code length: %d bits\n", length(encoded_data));
 
fprintf("Average code length per symbol: %g bits\n", length(encoded_data)/length(data));
fprintf("Average total length per symbol: %g bits\n", length(encoded_data)/length(data));

if (strlength(data) ~= strlength(decoded_data))
    fprintf("Length mismatch\n");
elseif (any(data~=decoded_data))
    fprintf("Wrong symbol\n");
else
    fprintf("Correct decoding!\n");
end

function [x_unique, x_probs] = alphabet_probabilities(X)
    x_unique = unique(X);
    x_probs = [];
    for i=1:numel(x_unique)
        x_probs = [x_probs, sum(X==x_unique(i))];
    end
    x_probs = x_probs./numel(X);
end

function x_entropy = entropy(X)
    [~, x_probs] = alphabet_probabilities(X);
    x_entropy = -sum(x_probs.*log2(x_probs));
end

function [ptr, symb] = split_data(data)
        data_splited = strsplit(data, "$");
        split1 = strsplit(data_splited(1), "(");
        split2 = strsplit(data_splited(2), ")");
        
        symb = split2(1);
        ptr = str2double(split1(2));
end

function [numbers, symbols] = data2arrays(encoded_data)
    encoded_data = strjoin(encoded_data,'');
    encoded_data = string(strsplit(string(encoded_data), '|'));
    encoded_data = encoded_data(1:end-1);
    
    numbers = [];
    symbols = [];
    
    for i = 1:length(encoded_data)
        [ptr, symb] = split_data(encoded_data(i));
        numbers = [numbers, ptr];
        symbols = [symbols,symb];
    end
end

function encoded_data_entropy = getEntropy(encoded_data)
    
    [numbers, symbols]= data2arrays(encoded_data);
    
    numbers_unique = unique(numbers);
    symbols_unique = unique(symbols);
    
    probs = [];
    for i=1:numel(numbers_unique)
        for j=1:numel(symbols_unique)
            res = sum((symbols==symbols_unique(j)).*(numbers==numbers_unique(i)));
            if(res > 0)
                probs = [probs, res];
            end
        end
    end
    
    probs = probs./numel(numbers);
    
    encoded_data_entropy = -sum(probs.*log2(probs));
end
