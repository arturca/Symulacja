figure();
stem(positive_good,'ro','MarkerSize',12);
hold on
stem(positive_green,'k*','MarkerSize',10);
stem(picked_on_bush,'bs','MarkerSize',10);
xlabel('Iteracja','FontSize',14);
ylabel('Ilość truskawek','FontSize',14);
legend('Ilość dobrych','Ilość zielonych','Ilość zebranych z krzaka','FontSize',14)