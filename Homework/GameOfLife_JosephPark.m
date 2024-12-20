clear, clc, close all;

% Starter Variables
N = 30;
M = 100;
scaleFactor = .45;
t_stop = 30;

% Goal 1: Plot a matrix of dead and alive
InitialLifeMatrix = randi([0,1], N, N);
% [rows, cols] = find(InitialLifeMatrix == 1);
% scatter(rows, cols)

% Actual ILM
ILM = zeros(M, M);
rowPosition = randi(abs(M-N-1)) + 1;
colPosition = randi(abs(M-N-1)) + 1;
ILM(rowPosition:rowPosition + (N-1), colPosition:colPosition + (N-1)) = InitialLifeMatrix;

% Cell Array
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

    % Count the number of alive neighbors
    % In-class version was not working, so used ChatGPT to help extract a
    % 3x3 matrix and used a sum function to calculate neighbors.
    for row = 1:size(previousLifeMatrix, 1)
        for col = 1:size(previousLifeMatrix, 2)
            neighbors = previousLifeMatrix(max(1, row-1):min(size(previousLifeMatrix, 1), row+1), ...
                                      max(1, col-1):min(size(previousLifeMatrix, 1), col+1));
            alive_neighbors = sum(neighbors(:)) - previousLifeMatrix(row, col);

            if previousLifeMatrix(row, col) == 1
                lifeMatrix(row, col) = (alive_neighbors == 2 || alive_neighbors == 3);
            else
                lifeMatrix(row, col) = (alive_neighbors == 3);
            end
        end
    end
end

function plotUpdate(generations)
    for i = 1:length(generations)
        axis([0 size(generations{i}, 1) 0 size(generations{i}, 2)]);
        axis manual;
        hold on;
        [row, col] = find(generations{i} == 1);
        cla;
        scatter(col, row);
        pause(0.1);
    end
end

plotUpdate(generations)