

clear all
clc

A = load('USPS.mat');
Amat = A.A;

% Number of principal components to use
p_values = [10, 50, 100, 200];

% Perform PCA using SVD
[U, S, V] = svd(A.A);

reconstruction_errors = zeros(size(p_values));

for i = 1:length(p_values)
    p = p_values(i);
    
    Ur = U(:, 1:p);
    Sr = S(1:p, 1:p);
    Vr = V(:, 1:p);
    
    reconstructed_A = Ur * Sr * Vr';
    
   
    reconstruction_errors(i) = norm(Amat - reconstructed_A, 'fro');
    
   
    reconstructed_image = reshape(reconstructed_A(1, :), [16, 16]); % Assuming the image size is 16x16
    subplot(1, length(p_values), i);
    imshow(reconstructed_image, []);
    title(['RI, p= ', num2str(p)]);
      reconstructed_images{i} = reconstructed_A;
end

% Display reconstruction errors
disp('Reconstruction Errors:');
disp(reconstruction_errors);

% Display the first two reconstructed images for each p
for i = 1:length(p_values)
    p = p_values(i);
    
    % Display or visualize the first two reconstructed images for each p
    figure;
    for j = 1:2
        subplot(1, 2, j);
        reconstructed_image = reshape(reconstructed_images{i}(j, :), [16, 16]); % Assuming the image size is 16x16
        imshow(reconstructed_image, []);
        title(['Reconstructed Image for p = ', num2str(p)]);
    end
end