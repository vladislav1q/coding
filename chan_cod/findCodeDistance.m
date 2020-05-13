function [code_distance, detected_errors, corrected_errors, weight_distribution] = findCodeDistance(G)

    [k,n] = size(G); 
    possible_inputs = dec2bin(0:2^k-1)-'0';
    code_vectors = encodeData(possible_inputs, G);
    weights = sum(code_vectors,2);
    possible_weights = 0:n; 
    weight_distribution=sum(weights==possible_weights,1);
    code_distance = find(double(weight_distribution(2:end) > 0),1);
    detected_errors = code_distance-1;
    corrected_errors = fix((code_distance-1)/2);

end

