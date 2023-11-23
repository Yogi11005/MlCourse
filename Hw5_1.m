
clc
clear all
data = randn(100, 2); % Sample data with 100 points and 2 features
k = 4;

% Step 1 from class : Randomly initialize centroids 
centroids = datasample(data, k, 'Replace', false);

% Number of iterations
maxIter = 100;
tolerance = 1e-5;
for iter = 1:maxIter
    % Step 2: Assign each data point to the nearest centroid
    distances = pdist2(data, centroids);
    [~, clusterIdx] = min(distances, [], 2);
    
    % Step 3: Update centroids
    newCentroids = zeros(k, size(data, 2));
    for i = 1:k
        newCentroids(i, :) = mean(data(clusterIdx == i, :));
    end
    
    % Step 4: Break when centroids wont change
    if max(abs(newCentroids(:) - centroids(:))) < tolerance
        break;
    end
    
    centroids = newCentroids;
end


colors = ['r', 'g', 'b', 'y', 'c', 'm'];
figure;
hold on;
for i = 1:k
    clusterPoints = data(clusterIdx == i, :);
    scatter(clusterPoints(:, 1), clusterPoints(:, 2), 50, colors(i), 'filled');
end
scatter(centroids(:, 1), centroids(:, 2), 200, 'k', 'filled', 'Marker', 'x');
title('K-means Clustering');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids');
hold off;



similarityMatrix = exp(-pdist2(data, data).^2); 

% Spectral clustering
numClusters = 4; % Number of clusters
clusteringResult = spectralcluster(similarityMatrix, numClusters);


colors = ['r', 'g', 'b', 'y', 'c', 'm']; 
figure;
hold on;
for i = 1:numClusters
    clusterPoints = data(clusteringResult == i, :);
    scatter(clusterPoints(:, 1), clusterPoints(:, 2), 50, colors(i), 'filled');
end
title('Spectral Clustering');
hold off;