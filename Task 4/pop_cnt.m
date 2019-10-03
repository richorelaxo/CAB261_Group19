function [para_cnt, food_cnt] = pop_cnt(map)

    food_map = map == -1;
    food_cnt = sum(food_map, 'all');
    
    para_map = map == 1;
    para_cnt = sum(para_map, 'all');

end