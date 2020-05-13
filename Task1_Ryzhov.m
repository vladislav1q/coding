%TASK 1
clear;
clc;
arr = 1:100;
arr_4 = arr(mod(arr, 4) == 0);
arr_7 = arr(mod(arr, 7) == 0);

fprintf("\nArr_4:\n");
fprintf("%i ", arr_4);
fprintf("\nArr_7:\n");
fprintf("%i ", arr_7);
fprintf("\n");

%TASK 2

vect = rand(1,10 + randi(10));
fprintf("\nVECTOR:\n");
fprintf("%i ", vect);
fprintf("\n");

vect(end-2:end) = 0;

fprintf("\nNEW VECTOR:\n");
fprintf("%i ", vect);
fprintf("\n");

[vect_max_value, vect_max_index] = max(vect);
fprintf("\nMAX VALUE AND ITS INDEX:\n");
fprintf("%d, %d\n", vect_max_value, vect_max_index);

%TASK 3
a = 5;
x = a-20:0.01:a+20;
y = Sinc(x,a);
figure
hold on
plot(x,y);
xlim([a-20, a+20])
grid on
hold off

%TASK 4

Plot_kln(1:15);

%TASK 5

roots = Solve_sq([1,1,0],[3,10,1],[1,2,1]);
roots
fprintf("\n");

%TASK 6
tree = {{1,{2}},{3,{4,5},6,7}};
tree{2}{2}{2} = {8,9};

function roots = Solve_sq(A,B,C)
roots = [];
    for i = 1:numel(A)
        a = A(i);
        b = B(i);
        c = C(i);
        D = (b^2-4*a*c);
        if a == 0 && b == 0
            if c == 0
                fprintf('ALL X ARE ROOTS\n');
            else
                fprintf('NO ROOTS\n');
            end
            elseif D >= 0
                if a ~= 0
                    x1 = (-b + sqrt(D)) / (2*a);
                    x2 = (-b - sqrt(D)) / (2*a);
                    roots = [roots; x1, x2];
                else
                    x1 = -c/b;
                    roots = [roots; x1,x1];
                end
        end
    end
end



function Plot_kln(k)
x = 0.01:0.01:100;
y = k.' .* (log(x));
graph = figure;
hold on
plt = plot(x,y);
set(plt, 'LineWidth', 0.1);
xlabel("x")
ylabel("k*log(x)")
lines = zeros(numel(k),1);
lines = "line " + k;
legend(lines)
title("LN")
xlim([0.01,2])
ylim([-5,2])
grid on
hold off

saveas(graph,'task_4.png');
end

function res = Sinc(x, a)
if nargin < 2
    a = 0;
end
res = sin(x-a)./(x-a);
res(isnan(res)) = 1;

end
