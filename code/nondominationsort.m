function f =nondominationsort(x, objnumber, variablenumber)
 
[N, m] = size(x);
clear m
% Initialize the front number to 1.
front = 1;
% There is nothing to this assignment, used only to manipulate easily in
% MATLAB.
F(front).f = [];
individual = [];
for i = 1 : N
    % Number of individuals that dominate this individual
    individual(i).n = 0;
    % Individuals which this individual dominate
    individual(i).p = [];
    for j = 1 : N
        dom_less = 0;
        dom_equal = 0;
        dom_more = 0;
        for k = 1 : objnumber
            if (x(i,variablenumber + k) < x(j,variablenumber + k))
                dom_less = dom_less + 1;
            elseif (x(i,variablenumber + k) == x(j,variablenumber + k))
                dom_equal = dom_equal + 1;
            else
                dom_more = dom_more + 1;
            end
        end
        if dom_less == 0 && dom_equal ~= objnumber
            individual(i).n = individual(i).n + 1;
        elseif dom_more == 0 && dom_equal ~= objnumber
            individual(i).p = [individual(i).p j];
        end
    end
    if individual(i).n == 0
        x(i,objnumber + variablenumber + 1) = 1;
        F(front).f = [F(front).f i];
    end
end
% Find the subsequent fronts
while ~isempty(F(front).f)
    Q = [];
    for i = 1 : length(F(front).f)
        if ~isempty(individual(F(front).f(i)).p)
            for j = 1 : length(individual(F(front).f(i)).p)
                individual(individual(F(front).f(i)).p(j)).n = ...
                    individual(individual(F(front).f(i)).p(j)).n - 1;
                if individual(individual(F(front).f(i)).p(j)).n == 0
                    x(individual(F(front).f(i)).p(j),objnumber + variablenumber + 1) = ...
                        front + 1;
                    Q = [Q individual(F(front).f(i)).p(j)];
                end
            end
        end
    end
    front =  front + 1;
    F(front).f = Q;
end

[temp,index_of_fronts] = sort(x(:,objnumber + variablenumber + 1));
for i = 1 : length(index_of_fronts)
    sorted_based_on_front(i,:) = x(index_of_fronts(i),:);
end
current_index = 0;

%% Crowding distance
% Find the crowding distance for each individual in each front
for front = 1 : (length(F) - 1)
    %    objective = [];
    distance = 0;
    y = [];
    previous_index = current_index + 1;
    for i = 1 : length(F(front).f)
        y(i,:) = sorted_based_on_front(current_index + i,:);
    end
    current_index = current_index + i;
    % Sort each individual based on the objective
    sorted_based_on_objective = [];
    for i = 1 : objnumber
        [sorted_based_on_objective, index_of_objectives] = ...
            sort(y(:,variablenumber + i));
        sorted_based_on_objective = [];
        for j = 1 : length(index_of_objectives)
            sorted_based_on_objective(j,:) = y(index_of_objectives(j),:);
        end
        f_max = ...
            sorted_based_on_objective(length(index_of_objectives), variablenumber + i);
        f_min = sorted_based_on_objective(1, variablenumber + i);
        y(index_of_objectives(length(index_of_objectives)),objnumber + variablenumber + 1 + i)...
            = Inf;
        y(index_of_objectives(1),objnumber + variablenumber + 1 + i) = Inf;
        for j = 2 : length(index_of_objectives) - 1
            next_obj  = sorted_based_on_objective(j + 1,variablenumber + i);
            previous_obj  = sorted_based_on_objective(j - 1,variablenumber + i);
            if (f_max - f_min == 0)
                y(index_of_objectives(j),objnumber + variablenumber + 1 + i) = Inf;
            else
                y(index_of_objectives(j),objnumber + variablenumber + 1 + i) = ...
                    (next_obj - previous_obj)/(f_max - f_min);
            end
        end
    end
    distance = [];
    distance(:,1) = zeros(length(F(front).f),1);
    for i = 1 : objnumber
        distance(:,1) = distance(:,1) + y(:,objnumber + variablenumber + 1 + i);
    end
    y(:,objnumber + variablenumber + 2) = distance;
    y = y(:,1 : objnumber + variablenumber + 2);
    z(previous_index:current_index,:) = y;
end
f = z();

