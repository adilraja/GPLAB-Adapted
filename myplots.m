function [train_mean, validation_mean, train_bar, validation_bar,train_stdvals,validation_stdvals]=myplots(myvars)
temp1=[];
temp2=[];
diver=[];
num_nodes=[];
tree_depth=[];
for i=1:50
%    if (i~=22 & i~=19 & i~=10 & i~=38 & i~=30)%this if is used to exclude outlier runs
        temp1=[temp1 myvars(i).state.bestfithistory(:,1)];
        temp2=[temp2 myvars(i).state.bestfithistory(:,2)];
        diver=[diver; myvars(i).state.diversityhistory.uniquegen];
        num_nodes=[num_nodes; myvars(i).state.bestnodeshistory];
        tree_depth=[tree_depth; myvars(i).state.bestlevelhistory];
 %   end
end
temp1=temp1';
temp2=temp2';
train_mean=mean(temp1);
train_stdvals=std(temp1);
validation_mean=mean(temp2);
validation_stdvals=std(temp2);
diver_mean=mean(diver);
diver_stdvals=std(diver);
num_nodes_mean=mean(num_nodes);
num_nodes_stdvals=std(num_nodes);
tree_depth_mean=mean(tree_depth);
tree_depth_stdvals=std(tree_depth);

numruns=length(train_mean);
train_bar=(1.96 .* (train_stdvals ./ sqrt(numruns)));
validation_bar=(1.96 .* (validation_stdvals ./ sqrt(numruns)));
diver_bar=1.96 .* (diver_stdvals ./ sqrt(numruns));
num_nodes_bar=1.96 .* (num_nodes_stdvals ./ sqrt(numruns));
tree_depth_bar=1.96.*(tree_depth_stdvals./sqrt(numruns));
figure;

errorbar(train_mean, train_bar, 'b');
%title('Error Graphs of Training Fitness');
%legend('MSE','Location','NorthEast')
title('Training','FontSize',16);
xlabel('Generations','FontSize',16);
ylabel('MSE_{s}','FontSize',16);
saveas(gcf,'Exp_Video1_err_bar_mse_train.fig','fig');
saveas(gcf,'Exp_Video1_err_bar_mse_train.jpg', 'jpg');
saveas(gcf,'Exp_Video1_err_bar_mse_train.eps', 'psc2');

figure;
errorbar(validation_mean,validation_bar,'r:');%Although it is for testing the variable validation is used here
%title('Error Graphs of Validation Fitness');
%legend('MSE','Location','NorthEast')
title('Testing','FontSize',16);
xlabel('Generations','FontSize',16);
ylabel('MSE_{s}','FontSize',16);
saveas(gcf,'Exp_Video1_err_bar_mse_test.fig','fig');
saveas(gcf,'Exp_Video1_err_bar_mse_test.jpg', 'jpg');
saveas(gcf,'Exp_Video1_err_bar_mse_test.eps', 'psc2');

figure
errorbar(diver_mean,diver_bar);
%title('Error Graph of population Diversity over 50 runs');
%legend('MSE','Location','NorthEast')
xlabel('Generarions');
ylabel('Diversity');
saveas(gcf, 'Exp_Video1_err_bar_diversity.fig','fig');
saveas(gcf,'Exp_Video1_err_bar_diversity.jpg', 'jpg');
saveas(gcf,'Exp_Video1_err_bar_diversity.eps', 'psc2');

figure;
errorbar(num_nodes_mean,num_nodes_bar);
%title('Error Graph of num nodes');
xlabel('Generations');
ylabel('Bloat');
saveas(gcf,'Exp_EUGP6_err_bar_numnodes.fig','fig');
saveas(gcf,'Exp_EUGP6_err_bar_numnodes.jpg', 'jpg');
saveas(gcf,'Exp_EUGP6_err_bar_numnodes.eps', 'psc2');

figure;
errorbar(tree_depth_mean,tree_depth_bar);
xlabel('Generation');
ylabel('Bloat');
saveas(gcf,'Exp_EUGP6_err_bar_treedepth.fig','fig');
saveas(gcf,'Exp_EUGP6_err_bar_treedepth.jpg', 'jpg');
saveas(gcf,'Exp_EUGP6_err_bar_treedepth.eps', 'psc2');
