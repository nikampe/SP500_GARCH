function m=debug_mean(data)

int=0;
for i=1:length(data)
    int=int+data(i);
end

m=int/length(data);