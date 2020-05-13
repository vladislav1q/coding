function [error_list, syndrome_list] = generateSyndromes(H)

    [k,n] = size(H); 
    possible_errors = dec2bin(1:2^n-1)-'0';
    [~,pt] = sort(sum(possible_errors,2));
    possible_errors = possible_errors(pt,:);
    
    error_list = [];
    syndrome_list = repmat([2],[1,k]);
    stack_ctl = 0;
    for i=1:2^n-1
        tmp = rem(possible_errors(i,:)*(H.'),2);
        if(~ismember(tmp,syndrome_list, 'rows'))
            syndrome_list = [syndrome_list; tmp];
            error_list = [error_list; possible_errors(i,:)];
            
            stack_ctl = stack_ctl+1;
            if(stack_ctl == 2^k-1)
                break
            end
        end
    end
    syndrome_list = syndrome_list(2:end,:);
end