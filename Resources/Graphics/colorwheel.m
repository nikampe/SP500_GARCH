% colorwheel.m
% Produce a color wheel to illustrate the RGB color system
% peter.gruber@usi.ch, 2014-09-28

myData=ones(6,1);
colors=[1 0 0;
        1 0 1;
        0 0 1;        
        0 1 1;
        0 1 0;
        1 1 0];
    colorName={'Red','Magenta','Blue','Cyan','Green','Yellow'}

h=pie(myData,myData,colorName);
hp = findobj(h, 'Type', 'patch');
for k=1:6
    set(hp(k),'FaceColor',colors(k,:),'EdgeColor','none');
end

rotate(h,[0 0 1],-30)