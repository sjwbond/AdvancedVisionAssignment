function output = pcObject(pc, pc_object)

count = 0
for i = 1:size(pc_object,1)
    
    if pc_object(i) == 1
        count = count+1;
    end
    
end

output = zeros(count,3);
count=0;

for i = 1:size(pc_object,1)
    if pc_object(i) == 1
        count = count+1;
        output(count,:) = pc.Location(i,:);
    end    
end


end