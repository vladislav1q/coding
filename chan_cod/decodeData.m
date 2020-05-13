function [decoded_data, b_error] = decodeData(encoded_data, H, error_list, syndrome_list)
    b_error = 0;
    
    syndrome = rem(encoded_data*(H.'),2);
    if(ismember(syndrome, syndrome_list, 'rows'))
        Y = repmat(syndrome,size(syndrome_list,1), 1);
        C = (syndrome_list==Y);
        F = all(C, 2);
        ptr = find(F);
        
        %ptr = find(syndrome, syndrome_list,'rows');
        encoded_data = rem(encoded_data + error_list(ptr,:),2);
        b_error = 1;
    end
    [n,k] = size(H);
    decoded_data = encoded_data(1:(k-n));
end
