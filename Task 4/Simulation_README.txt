Simulation Functions

cell_occupied.m - checks for occupied map cells and returns contents.
random_placement.m - places new food randomly in map cells.
local_placement.m - places new food in localised quadrant, chosen randomly.
init_array.m - creates initial simulation map, based on food strategy (random/localised)
para_simulation.m - Main Agent Simulation, takes in parameter set and runs simulation.
para_step.m - Moves all parasites for 1 step in a random direction.
food_update.m - Updates map with current food, minus those eaten.
food_dies.m - Removes food from map that has died due to food threshold f_th.
food_grows.m - Adds food to map based on new_food amount and placement strategy (random/localised).
pop_cnts.m - counts parasite and food population at a single step.
plot_counts.m - Plots population and quadrant coutns.
mapcolour.m - Converts simulation map into an rgb array 200x200x3 for visualization.
Run_sim - Task 4 simulation runs used for report.
test_functions.m - Testing funciton only.
ParamSweep.m - Testing parameters by seeping throug hall combinations (don't run!).