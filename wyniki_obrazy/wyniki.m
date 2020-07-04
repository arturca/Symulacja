clear;
dane_fig = figure();
load('log.mat')
stem(positive_good,'ro','MarkerSize',12);
hold on
stem(positive_green,'k*','MarkerSize',10);
stem(picked_on_bush,'bs','MarkerSize',10);
xlabel('Iteracja','FontSize',14);
ylabel('Iloœæ truskawek','FontSize',14);
legend('Iloœæ dobrych','Iloœæ zielonych','Iloœæ zebranych z krzaka','FontSize',14)
saveas(dane_fig,'dane_fig.png')