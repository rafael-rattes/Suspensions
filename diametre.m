% Lire l'image du microscope optique
image = imread('Gouttes N2.jpg');

% Variables du code
bounds = [0.8 8.0];  % Diamètre max et min en micromètres
sensibility = 0.78;  % imfindcircles sensibilité
ratio = 18.11;       % pixels/micromètre (résolution du microscope)

% Améliorer le contraste de l'image pour le fonction imfindcircles
grayImage = rgb2gray(image);

% Détecter les cercles dans l'image
bounds_pixel = round(bounds/2*ratio); % Limites de la fonction par rapport au radii en pixels
[centers, radii] = imfindcircles(grayImage, bounds_pixel, 'ObjectPolarity', 'dark', 'Sensitivity', sensibility);

% Calculer les diamètres des cercles
diameters = 2 * radii / ratio;

% Calculer le diamètre moyen et l'écart type
meanDiameter = mean(diameters);
stdDiameter = std(diameters);

% Afficher l'image originale
figure;
subplot(1, 2, 1);
imshow(image);
title('Image Originale');

% Afficher l'image avec les cercles détectés
subplot(1, 2, 2);
imshow(grayImage);
hold on;
viscircles(centers, radii, 'EdgeColor', 'b');
title('Cercles Détectés');

% Afficher les informations de mesure
numCircles = length(diameters);
infoText = sprintf('Nombre de cercles: %d\nDiamètre moyen: %.2f μm\nÉcart type: %.2f μm', numCircles, meanDiameter, stdDiameter);
annotation('textbox', [0.7, 0.1, 0.2, 0.2], 'String', infoText, 'FitBoxToText', 'on');

hold off;