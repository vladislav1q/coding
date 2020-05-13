function [encoded_data] = encodeData(input_data, G)
    encoded_data = input_data*G;
    encoded_data = rem(encoded_data,2);
    %encoded_data = encoded_data.';
    %encoded_data = encoded_data(:);
end