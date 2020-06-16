function DisplaySimGrid(simPlane, planeSize, it, dispSize)
    subplot(2, 2, 1)
    sgtitle(["Iteration : "  num2str(it)]);
    
    pcolor(simPlane.healthState)
    daspect([1,1,1])    
    title('Health state');
    
    subplot(2, 2, 2)
    pcolor(simPlane.isRevealed)
    daspect([1,1,1])
    title('Tested positive');
    
    subplot(2, 2, 3)
    pcolor(simPlane.wasRecovered)
    daspect([1,1,1])
    title('Recovered');
    
    subplot(2, 2, 4)
    pcolor(simPlane.isDead)
    daspect([1,1,1])
    title('Deaths');
    
    drawnow();
    
%     [J, I] = find(healthState == 1);
%     plot(I, J,'.','Marker', 's', 'MarkerFaceColor', 'b', 'MarkerSize', dispSize);
%     
%     [J, I] = find(healthState == 2);
%     plot(I, J,'.','Marker', 's', 'MarkerFaceColor', 'r', 'MarkerSize', dispSize);
%     
%     [J, I] = find(healthState == 3);
%     p = plot(I, J,'.','Marker', 's', 'MarkerFaceColor', 'g', 'MarkerSize', dispSize);
%     
%     [J, I] = find(healthState == 4);
%     plot(I, J,'.','Marker', 's', 'MarkerFaceColor', 'y', 'MarkerSize', dispSize);
%     
%     legend(["infecting", "sick", "hospitalized", "dead"]);
%     axis([1 planeSize 1 planeSize]);
%     daspect([1,1,1])    
%     text(2,2.5,['cykl ' num2str(iteration)]);
%     hold off
end
