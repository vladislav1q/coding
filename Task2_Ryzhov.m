clear;
clc;

%TASK 1

load strings
[x_unique, x_probs] = alphabet_probabilities(X);
[y_unique, y_probs] = alphabet_probabilities(Y);

%TASK 2

entropy(X);

%TASK 3
entropy(X);
conditional_value_entropy(X,Y,'b');

%TASK 4

conditional_entropy(X,Y);

%TASK 5

%joint_entropy(X,Y);

%TASK 6

conditional_entropy(X,Y) <= entropy(X)
entropy(X) <= log2(numel(x_unique))
conditional_entropy(Y,X) <= entropy(Y)
entropy(Y) <= log2(numel(y_unique))

round(joint_entropy(X,Y),4) == round(entropy(X) + conditional_entropy(Y,X),4)
round(joint_entropy(Y,X),4) == round(entropy(Y) + conditional_entropy(X,Y),4)

entropy(X) - conditional_entropy(X,Y) == entropy(Y) - conditional_entropy(Y,X)

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

function x_entropy_cond = conditional_value_entropy(X,Y,y)
    X_if_y = X(Y==y);
    x_entropy_cond = entropy(X_if_y);
end

function entropy = conditional_entropy(X,Y)
    arr=[];
    [y_unique, y_probs] = alphabet_probabilities(Y);
    
    for i=1:numel(y_probs)
        arr = [arr, y_probs(i)*conditional_value_entropy(X,Y,y_unique(i))];
    end
    entropy = sum(arr);
end

function entropy_joint = joint_entropy(X,Y)  
    joint_distr = (string(X.') + string(Y.')).';
    [~, joint_distr_probs] = alphabet_probabilities(joint_distr);
    
    entropy_joint = 0;
    for i=1:numel(joint_distr_probs)
        entropy_joint = entropy_joint - joint_distr_probs(i)*log2(joint_distr_probs(i));
    end
end
