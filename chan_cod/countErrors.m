function [n_errors] = countErrors(original_data, distorted_data)

    n_errors = sum(double(original_data ~= distorted_data));

end