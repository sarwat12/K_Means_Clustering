#Sarwat Shaheen #214677322
clear; clc;
#load dataset twodpoints.txt
D = load('twodpoints.txt');
% N-dimensional output vector assigning each point to its cluster
O = zeros(length(D),1);
%Plotting the initial unclustered data
X1 = D(:,1); X2 = D(:,2);
plot(X1,X2,'r*'); xlabel('X1'); ylabel('X2'); title('Plot of dataset.');
str = {'For this dataset, 3 clusters would be ideal for fitting the data.'};
text(-4.8,18,str,'FontSize',17);

%Choosing the 3 initial centers manually by hand
Mean1 = D(200,:); Mean2 = D(131,:); Mean3 = D(8,:);

%Implementation of the K-means algorithm with 50 iterations for convergence
for i = 1:50
  % Creating the three cluster grouping matrices
  C1 = zeros(1,2); C2 = zeros(1,2); C3 = zeros(1,2);
  % Iterating over all points in the dataset
  for j = 1:length(D)
    % Calculating the minimum euclidean distance from mean to dataset
    %Then assigning each dataset to its particular cluster
    dist1 = norm(D(j,:) - Mean1, 2);
    dist2 = norm(D(j,:) - Mean2, 2);
    dist3 = norm(D(j,:) - Mean3, 2);
    if ((dist1 < dist2) && (dist1 < dist3))
      O(j,1) = 1;
      C1 = [C1; D(j,:)];
    elseif ((dist2 < dist1) && (dist2 < dist3))
      O(j,1) = 2;
      C2 = [C2; D(j,:)];
    else
      O(j,1) = 3;
      C3 = [C3; D(j,:)];
    endif
  endfor 
  % Updating the centers of each cluster
  Mean1(1,1) = sum(C1(:,1)) / (length(C1) - 1); Mean1(1,2) = sum(C1(:,2)) / (length(C1) - 1); 
  Mean2(1,1) = sum(C2(:,1)) / (length(C2) - 1); Mean2(1,2) = sum(C2(:,2)) / (length(C2) - 1);
  Mean3(1,1) = sum(C3(:,1)) / (length(C3) - 1); Mean3(1,2) = sum(C3(:,2)) / (length(C3) - 1);
endfor

% Final N-dimensional vector outptut
disp(O);
%Plot of data after k-means clustering, with different color for each cluster
scatter(C1(:,1),C1(:,2)); hold on; 
scatter(C2(:,1),C2(:,2));
scatter(C3(:,1),C3(:,2));
xlabel('X1'); ylabel('X2'); title('Plot of dataset after k-means clustering.');
text(D(200,1),D(200,2),'\leftarrowInitial center-1.','FontSize',15);
text(D(131,1),D(131,2),'Initial center-2\rightarrow','HorizontalAlignment','right','FontSize',15);
text(D(8,1),D(8,2),'\leftarrowInitial center-3.','FontSize',15);

text(Mean1(1,1),Mean1(1,2),'x\leftarrowFinal center-1.','Color', 'red','FontSize',13);
text(Mean2(1,1),Mean2(1,2),'x\leftarrowFinal center-2.','Color', 'red','FontSize',15);
text(Mean3(1,1),Mean3(1,2),'x\leftarrowFinal center-3.','Color', 'red','FontSize',15);
text(-10,18,'Second instance of manually chosen initial centers,C1 = twodpoints[200],C2 = twodpoints[131],C3 = twodpoints[8].','FontSize',10);
t = linspace(0,2*pi,100)'; 
c1x = 3.2.*cos(t) + Mean1(1,1); c1y = 3.3.*sin(t) + Mean1(1,2); plot(c1x,c1y); text(3.3,-1.6,'Cluster 1','FontSize',15);
c2x = 5.*cos(t) + Mean2(1,1); c2y = 4.*sin(t) + Mean2(1,2); plot(c2x,c2y); text(-7,15,'Cluster 3','FontSize',15);
c3x = 5.*cos(t) + Mean3(1,1); c3y = 4.*sin(t) + Mean3(1,2); plot(c3x,c3y); text(10.1,13,'Cluster 2','FontSize',15);
