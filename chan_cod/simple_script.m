% One iteration
clc
clear
load('codes')

i = 3;
code = codes(i);    % 1-5
if(i == 3)
    G = [codes(3).G(:,3),codes(3).G(:,5:7), codes(3).G(:,1:2), codes(3).G(:,4), codes(3).G(:,8)];
    H = [codes(3).H(:,3),codes(3).H(:,5:7), codes(3).H(:,1:2), codes(3).H(:,4), codes(3).H(:,8)];
    code.G = G;
    code.H = H;
end
fprintf("%s\n", code.name);

k = size(code.G,1); % input block size
m = size(code.H,1); % check block size
n = size(code.G,2); % output block size

error_number = 1;

data = randi([0 1], 1, k);

% 1: Encode data
encoded_data = encodeData(data, code.G);

% 2: Find spectrum and code distance
[code_distance, detected_errors, corrected_errors, ...
    weight_distribution] = findCodeDistance(code.G); 

possible_weights = 0:n; 
fprintf("Weight spectrum\n");
disp([possible_weights;weight_distribution])

fprintf("Code distance: %d\n", code_distance);   
fprintf("Detected error weight: %d\n", detected_errors);   
fprintf("Corrected error weight: %d\n", corrected_errors); 

% Imagine there is a noisy channel here %
distorted_data = addNErrors(encoded_data, error_number);

% 3: Count errors
fprintf("The distorted message of %d bits contains %d errors\n", ...
    numel(encoded_data), ...
    countErrors(encoded_data, distorted_data));

% 4: Generate errors and syndromes
[error_list,syndrome_list] = generateSyndromes(code.H);

% 5: Decode data
[decoded_data, b_error] = decodeData(distorted_data, code.H, error_list, syndrome_list);

if b_error
    fprintf("Errors have been detected\n");
else
    fprintf("No errors have been detected\n");
end
fprintf("The decoded message of %d bits contains %d errors\n", ...
    numel(encoded_data), ...
    countErrors(data, decoded_data));
