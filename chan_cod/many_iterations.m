% Many iterations
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

G = code.G;
H = code.H;

[code_distance, detected_errors, corrected_errors] = findCodeDistance(code.G); 
fprintf("Code distance: %d\n", code_distance);   
fprintf("Detected error weight: %d\n", detected_errors);   
fprintf("Corrected error weight: %d\n", corrected_errors); 

[error_list,syndrome_list] = generateSyndromes(code.H);

error_number = 1;   %
fprintf("Add %d errors\n", error_number);
% error_probability = 1e-2;
% fprintf("Set error probability %g\n", error_probability);
n_iteration  = 1e5;

pd_counter = 0;
pw_counter = 0;
pb_counter = 0;
for i = 1:n_iteration
    input_data = randi([0 1], 1, k);
    encoded_data = encodeData(input_data, code.G);
    
    distorted_data = addNErrors(encoded_data, error_number);
%     distorted_data = addPErrors(encoded_data, error_probability);
    b_contains_error = countErrors(encoded_data, distorted_data) > 0;
    
    [decoded_data, b_error_detected] = decodeData(distorted_data, code.H, error_list, syndrome_list);
    pd_counter = pd_counter + (~b_error_detected && b_contains_error);
    n_missed_errors = countErrors(input_data, decoded_data);
    
    pw_counter = pw_counter + logical(n_missed_errors);
    pb_counter = pb_counter + countErrors(input_data, decoded_data);
end
fprintf("Detection error rate: %f\n", pd_counter/n_iteration);
fprintf("Correction error rate: %f\n", pw_counter/n_iteration);
fprintf("Bit error rate: %f\n", pb_counter/k/n_iteration);