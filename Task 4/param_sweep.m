% Parameter sweep
M = 200;
N = 200;
pop_dens = [0.1 0.2 0.3 0.4];
f1 = (1:1:15);
f2 = (0:0.01:0.1);
f3 = [100 200 300 400];
food_growth = false;

pop_cnts = [];
%zeros(size(pop_dens, 2)*size(f1, 2)*size(f2, 2)*size(f3, 2), 1);
i = 1;

tic;
for p = pop_dens    
    for t = f1
        for d = f2
            for g = f3
                pop_cnts = [pop_cnts; para_sim(M, N, p, food_growth, d, t, g)];
                i = i + 1;
            end
        end
    end
end
t_comp=toc;

