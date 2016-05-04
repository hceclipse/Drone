function X = Obsticals(Ox,Oy,array_final)
%% Adding obsicals

% % Simple square
% Ox = [25 25 10 10];   % X position of the vectors
% Oy = [25 10 10 25];    % Y position of the vectors

% % Polygone
% Ox = [10 20 5 0];
% Oy = [30 5 5 10];

% % Polygone
% Ox = [10 20 5 0];
% Oy = [30 5 5 10];

% % Simple big square shifted
% Ox = [200 200 20 20];   % X position of the vectors
% Oy = [200 20 20 200];    % Y position of the vectors

% % Simple big square shifted
% Ox = [200 200 100 100];   % X position of the vectors
% Oy = [200 20 20 200];    % Y position of the vectors

% % Hexagone
% Ox = [30 20 10 20 30 40];
% Oy = [20 20 10 5 3 10];

% % Droite
% Ox = [40 40];
% Oy = [9 50];

length_shape_obj = length(Ox);
Ox(length(Ox)+1) = Ox(1);
Oy(length(Oy)+1) = Oy(1);
plot (Ox,Oy);
crossed = 0;
crossed2times = 0;
% mem_Col = ones(2000,4)*NaN;
route1_loop = 0;
route2_loop = 0;
route2_loop_previous =0;
route1_loop_previous =0;
save_2 = 0;
save_1 = 0;
points_linked =1;
final_obstical = 0;
save_old_and_new =[]
save_nolonger_pts = [];
for loop = 1:300
    plot(array_final(loop,1),array_final(loop,2),'o');
%     pause(0.5)
    quiver(array_final(loop,1),array_final(loop,2),array_final(loop+1,1)-array_final(loop,1),array_final(loop+1,2)-array_final(loop,2))
    for loop2 = 1:length(Ox)-1;
        Col = collision([Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)],[array_final(loop,1) array_final(loop,2)],[array_final(loop+1,1) array_final(loop+1,2)]);
        Col2 = collision([Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)],[array_final(loop+1,1) array_final(loop+1,2)],[array_final(loop,1) array_final(loop,2)]);
        Col3 = collision([array_final(loop,1) array_final(loop,2)],[array_final(loop+1,1) array_final(loop+1,2)],[Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)]);
        Col4 = collision([array_final(loop+1,1) array_final(loop+1,2)],[array_final(loop,1) array_final(loop,2)],[Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)]);
        if (length(Col4)==2 || length(Col3)==2 || length(Col2)==2 || length(Col)==2)
            crossed = crossed+1;

            crossed2times = crossed2times+1;
        end
        
        if isnan(Col4)
        else
            
            mem_Col(crossed,3) = crossed
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col4(1);
            mem_Col(crossed,2) = Col4(2);
        end
        if isnan(Col3)
        else
            
            mem_Col(crossed,3) = crossed
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col3(1);
            mem_Col(crossed,2) = Col3(2);
        end
        
        if isnan(Col2)
        else
            
            mem_Col(crossed,3) = crossed
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col2(1);
            mem_Col(crossed,2) = Col2(2);
        end
        if isnan(Col)
        else
            mem_Col(crossed,3) = crossed
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col(1);
            mem_Col(crossed,2) = Col(2);
        end
        
    end
%     crossed2times
    if crossed2times ==1
        plot(array_final(loop,1),array_final(loop,2),'x');
        if save_1 == save_2
            save_1 = save_1+1;
            save_nolonger_pts(save_1,1) = loop;
            save_nolonger_pts(save_1,2) = points_linked;
            save_nolonger_pts
        end
    end
    if crossed2times == 2
        if isempty(save_nolonger_pts);
            save_1 = save_1+1;
            save_nolonger_pts(save_1,1) = loop;
            save_nolonger_pts(save_1,2) = points_linked;
            save_nolonger_pts
        end
        save_2= save_2+1;
        save_nolonger_pts2(save_2,1) = loop+1;
        save_nolonger_pts2(save_2,2) = points_linked;
        save_nolonger_pts2
        
        if length(save_nolonger_pts2) ~= length(save_nolonger_pts)
            save_1 = save_1+1;
            save_nolonger_pts(save_1,1) = loop;
            save_nolonger_pts(save_1,2) = points_linked;
            save_nolonger_pts
        end
        points_linked = points_linked+1;
        %% GOTODO here
        if (pdist([mem_Col(crossed-1,1),mem_Col(crossed-1,2); array_final(loop+1,1),array_final(loop+1,2)],'euclidean'))<(pdist([mem_Col(crossed,1),mem_Col(crossed,2);array_final(loop+1,1),array_final(loop+1,2)],'euclidean'));
            temp_val = mem_Col(crossed,1:4);
            mem_Col(crossed,1:4) = mem_Col(crossed-1,1:4);
            mem_Col(crossed-1,1:4) = temp_val;
            array_final(loop+1,1:2);
        else
            array_final(loop+1,1:2);
            mem_Col(crossed,1:4);
            mem_Col(crossed-1,1:4);
        end
        
        where_intersect_enter = mem_Col(crossed-1,4);
        
        
        enter_point = [mem_Col(crossed-1,1) mem_Col(crossed-1,2) ];
        where_intersect_out = mem_Col(crossed,4);
        out_point = [mem_Col(crossed,1) mem_Col(crossed,2) ];
        notdone =1;
        
        % the point of the object folowed in clockwise
        where_next_point = where_intersect_enter;
        while (notdone)
            
%             if where_intersect_out < where_intersect_enter
                route1_loop = route1_loop+1;
                save_point(route1_loop,1) = mem_Col(crossed-1,1);
                save_point(route1_loop,2) = mem_Col(crossed-1,2);
                temp = where_intersect_enter;
                for loopx = where_intersect_out+1:where_intersect_enter
                    
                    route1_loop = route1_loop+1;
                    save_point(route1_loop,1)= Ox(temp);
                    save_point(route1_loop,2)= Oy(temp);
                    temp = temp-1;
                end
                route1_loop = route1_loop+1;
                
                save_point(route1_loop,1)= out_point(1);
                save_point(route1_loop,2)= out_point(2);
                
                d1 =0;
                d1_final =0;
                temp1 = 0;
                clear save_point_temp1;
                for loop_comp_route = route1_loop_previous+1:route1_loop-1;
                    d1 = pdist(save_point(loop_comp_route:loop_comp_route+1,:),'euclidean');
                    d1_final = d1_final+d1;
                    temp1 = temp1+1;
                    save_point_temp1(temp1,1:2) = save_point(loop_comp_route,:);
                    
                    
                end
                save_point_temp1(temp1+1,1:2) = save_point(loop_comp_route+1,:);
%             end
            
%             if where_intersect_out < where_intersect_enter
                route2_loop = route2_loop+1;
                save_point2(route2_loop,1) = mem_Col(crossed-1,1);
                save_point2(route2_loop,2) = mem_Col(crossed-1,2);
                
                temp = where_intersect_enter+1;
                for loopx = 1: where_intersect_out+length_shape_obj-where_intersect_enter;
                    if temp == length_shape_obj+1;
                        temp = 1;
                    end
                    route2_loop = route2_loop+1;
                    save_point2(route2_loop,1)= Ox(abs(temp));
                    save_point2(route2_loop,2)= Oy(abs(temp));
                    temp = temp+1;
                    
                end
                route2_loop = route2_loop+1;
                save_point2(route2_loop,1)= out_point(1);
                save_point2(route2_loop,2)= out_point(2);
                
                d2 = 0;
                d2_final =0;
                temp2 = 0;
                
                clear save_point_temp2;
                for loop_comp_route = route2_loop_previous+1:route2_loop-1
                    d2 = pdist(save_point2(loop_comp_route:loop_comp_route+1,:),'euclidean');
                    d2_final = d2_final+d2;
                    temp2 = temp2+1;
                    save_point_temp2(temp2,1:2) = save_point2(loop_comp_route,:);
                end
                save_point_temp2(temp2+1,1:2) = save_point2(loop_comp_route+1,:);
%             end
            
            
            
            %             clear save_old_and_new;

            if d1_final< d2_final
                final_obstical = final_obstical+1;
                plot(save_point_temp1(:,1),save_point_temp1(:,2),'r');
                save_point_temp1(:,3) = final_obstical;
                save_old_and_new = vertcat(save_old_and_new,save_point_temp1);
            else
                final_obstical = final_obstical+1;
                plot(save_point_temp2(:,1),save_point_temp2(:,2),'g');
                save_point_temp2(:,3) = final_obstical;
                save_old_and_new = vertcat(save_old_and_new,save_point_temp2);
            end
            
            route1_loop_previous =route1_loop;
            route2_loop_previous =route2_loop;
            
            notdone =0;
        end
%         save_nolonger_pts = [];
        crossed2times =0;
    end
    %     pause (0.1)
end
% plot(save_point(:,1),save_point(:,2),'r');
% plot(save_point2(:,1),save_point2(:,2),'g');
hold off;


loop_other_order = max(save_nolonger_pts2(:,2));
a =0 ;
for loop = 1:max(save_nolonger_pts2(:,2))
    array_temp1 = array_final(1:save_nolonger_pts(max(save_nolonger_pts2(:,2)-a)),:);
    %%TODO trouver une meilleur methode...
    save_old_and_new_temp = save_old_and_new(:,3)==loop_other_order;
    save_old_and_new_temp = find(save_old_and_new_temp,10);
    %         array_temp2 =[]
    for loop2 = 1:length(save_old_and_new_temp)
        save_old_and_new_temp(loop2);
        array_temp2(loop2,1:2) = save_old_and_new(save_old_and_new_temp(loop2),1:2)
    end
    %         array_temp2
    array_temp3 = array_final(save_nolonger_pts2(max(save_nolonger_pts2(:,2)-a)):length(array_final),:);
    loop_other_order =loop_other_order-1;
    array_final = vertcat(array_temp1,array_temp2,array_temp3);
%     length(array_final);
    a = a+1;
end
figure(100);
hold on
% plot(Ox,Oy);
plot(Ox,Oy);
plot(array_final(:,1),array_final(:,2))
% plot(array_final(save_nolonger_pts(:,1),1),array_final(save_nolonger_pts(:,1),2),'o');
% plot(array_final(save_nolonger_pts2(:,1),1),array_final(save_nolonger_pts2(:,1),2),'x');
hold off;

X = array_final;
end

