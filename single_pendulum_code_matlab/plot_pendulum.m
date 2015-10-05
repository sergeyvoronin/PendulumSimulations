function plot_pendulum(l,angles,save_images)
    close all;
    figure(1);
    for i=1:length(angles)
        theta = angles(i);
        if 0 <= theta < pi/2
            x = l*cos(pi/2-theta);
            y = -l*sin(pi/2-theta);
        elseif pi/2 <= theta < pi
            x = l*cos(theta - pi/2);
            y = l*sin(theta - pi/2);
        elseif -pi/2 <= theta < 0
            x = -l*cos(pi/2-abs(theta));
            y = -l*sin(pi/2-abs(theta));
        elseif -pi <= theta < -pi/2
            x = -l*cos(abs(theta) - pi/2);
            y = l*sin(abs(theta) - pi/2);
        else
            fprintf('invalid theta\n');
        end
        x
        y
        plot([0 x], [0 y], 'linewidth',3);
        hold on
        nsegments = 75;
        r = 0.3;
        th = 0:2*pi/nsegments:2*pi;
        xunit = r * cos(th) + x;
        yunit = r * sin(th) + y;
        h = plot(xunit, yunit, 'r', 'linewidth',3);
        hold off
        xlim([-1.2*l,1.2*l]);
        ylim([-1.2*l,1.2*l]);
        pause(0.01);

        if save_images == 1
            if i==1 || mod(i,50) == 0
                print('-depsc',['images/frame', num2str(i), '.eps']);
            end
        end
    end
end
