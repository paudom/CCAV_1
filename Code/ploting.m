load BethP2
figure
hold on;
plot(t,f,'LineWidth',1.2,'Color',[0.8039 0.5215 0.2471])
plot(t,-frame_p,'LineWidth',1.2,'Color',[0.6980 0.1333 0.1333])
title('Frame Prediction for P=2');
xlabel('Samples');
ylabel('Amplitude');
legend('Original Frame','Predicted Frame');
grid on;
hold off;
axis tight