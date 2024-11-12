clear, clc, close all;

% Notes
% 1. Going to use a matrix to store the cells
%    that are alive and dead. (1 - alive, 0 -dead)
% 2. We will use a cell array to store each time step of
%    the matrix that contains life.
% 3. We will use a scatter plot to show that values 

% Rules:
% 1. Any live cell with fewer than two live neighbors dies.
% 2. Any live cell with two or three live nghbrs lives.
% 3. Any live cell with >3 live nghbrs dies.
% 4. Any dead cell with EXACTLY three comes to life.

% Starter Variables
N = 30;
M = 100;
scaleFactor = .45;
t_stop = 30;

% Goal 1: Plot a matrix of dead and alive
InitialLifeMatrix = round(rand([N,N])- scaleFactor);
% [rows, cols] = find(InitialLifeMatrix == 1);
% scatter(rows, cols)

% Actual ILM
ILM = zeros(M, M);
rowPosition = randi(abs(M-N-1)) + 1;
colPosition = randi(abs(M-N-1)) + 1;
ILM(rowPosition:rowPosition + (N-1), colPosition:colPosition + (N-1)) = InitialLifeMatrix;

% Goal 2: Need to write code that implements that ruleset for evolution
% Throw the matrix into a loop to start computing rules
% Use a cell array to store each generation

generations = cell([t_stop,1]);
generations{1} = ILM;

for t = 2 : t_stop
    generations{t} = EvolveLM(generations{t-1});
end


% Functions
function lifeMatrix = EvolveLM(previousLifeMatrix)
    % Run the algorithm here to determine the next evolution
    [r,c] = size(previousLifeMatrix); % grabs the numbers of rows and columns
    PLM = previousLifeMatrix; 
    lifeMatrix = zeros(r,c);
    % loop through each row and column
    for rows = 1 : r 
        for cols = 1 : c
            if cols == 1
                if rows == 1
                    neighbors = PLM(rows, cols+1) + PLM(rows + 1, cols + 1) + PLM(rows + 1, cols);
                    lifeMatrix(rows, cols) = updateLifeCondition(neighbors, PLM(rows, cols));
                elseif rows == r
                    neighbors = PLM(rows, cols+1) + PLM(rows -1, cols + 1) + PLM(rows - 1, cols);
                    lifeMatrix(rows, cols) = updateLifeCondition(neighbors, PLM(rows, cols));
                else
                    neighbors = PLM(rows - 1, cols) + PLM(rows - 1, cols + 1) + PLM(rows, cols + 1) + ...
                        + PLM(rows + 1, cols + 1) + PLM(rows + 1, cols);
                end
            end
        end
    end

end

function lifeOrDeath = updateLifeCondition(neighbors, currentCellStatus)
% This function determines based on neighbor value if the cell is alive or
% dead in the next iteration

% Rules:
% 1. Any live cell with fewer than two live neighbors dies.
% 2. Any live cell with two or three live nghbrs lives.
% 3. Any live cell with >3 live nghbrs dies.
% 4. Any dead cell with EXACTLY three comes to life.

if currentCellStatus == 1 && neighbors < 2
    lifeOrDeath = 0;
elseif currentCellStatus == 1 && (neighbors == 2 || neighbors == 3)
    lifeOrDeath = 1;
elseif currentCellStatus == 1 && neighbors > 3
    lifeOrDeath = 0;
elseif currentCellStatus == 0 && neighbors == 3
    lifeOrDeath = 1;
else
    lifeOrDeath = 0;
    warning("There could be an issue, double check");
end
end

function plotUpdate(generations)
    for i = 1:length(generations)
        [row, col] = find(generations{i} == 1)
        cla
        scatter(col, row)
        pause(0.1)
    end
end

plotUpdate(generations)