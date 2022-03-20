function MSE = MSE_Utku_Acar(original_image,filtered_image)
m = size(original_image);%could be length(.) also
n = size(filtered_image);% this does not matter bc images have same size(256*256)
sum=0;
temp=0;
for i=1:m(1) % it could be n since they have same size
    for j=1:m(2)
        temp=temp +(original_image(i,j)-filtered_image(i,j))^2/(m(1)*m(2));
    end
    sum= sum + temp; % adding up the error at current iteration(j)
    temp=0;%% initialing temp for next iteration(i)
end
MSE = sum;%% assigning the result to the output 
end