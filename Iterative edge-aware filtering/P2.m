clear
flash=im2double(imread('images/puppets_00_flash.jpg'));
noflash=im2double(imread('images/puppets_01_noflash.jpg'));

flash = imresize(flash,0.5);
noflash = imresize(noflash,0.5);
image= noflash;
W = 5;
Lambda = 1;

imageFiltered = image;
[height,width,~] = size(image);

%compute P hat horizental and vertical
pi_hat_hor = zeros(height,width);
pi_hat_ver = zeros(height,width);

%compute p horizantal and vertical
pi_hor = zeros(height,width, 2*W+1);
pi_ver = zeros(height,width, 2*W+1);

sigma = 0.5;
alpha = 2;
%% 

for i=1:height-1
    for j=1:width
        I_p = reshape(image(i,j,:),[3,1]);
        I_prim = reshape(image(i+1,j,:),[3,1]);
        pi_hat_hor(i,j)=inv(1+ power(norm( ( I_p - I_prim )/sigma),2) );
    end
end
    
 for i=1:height
    for j=1:width-1
        I_p = reshape(image(i,j,:),[3,1]);
        I_prim = reshape(image(i,j+1,:),[3,1]);
        pi_hat_ver(i,j)=inv(1+ power(norm( ( I_p - I_prim )/sigma),2) );
    end
end   
% for i=1:width
%     for j=1:height-1
%         I_p = reshape(image(i,j,:),[3,1]);
%         I_prim = reshape(image(i,j+1,:),[3,1]);
%         pi_hat_ver(i,j) = 1/(1 + power(norm((I_p - I_prim)/sigma),alpha));
%     end
% end
%% 
for j=1:width
    for i=1:height
        start = max(1,i-2*W-1);
        finish = min(height,i+2*W+1);
        for m=start:finish
            if i==m
                pi_hor(i,j,W+1)=1;      
            elseif abs(i-m) <= W  
                pi_hor_t=1;
                for k=i:m
                    pi_hor_t=pi_hor_t*pi_hat_hor(k,j);
                end                    
                pi_hor(i,j,W+m-i+1)=pi_hor_t;
            end
        end
    end
end
for j=1:width
    for i=1:height
        start = max(1,j-2*W-1);
        finish = min(width,j+2*W+1);
        for m=start:finish
            if j==m
                pi_ver(i,j,W+1)=1;      
            elseif abs(j-m) <= W  
                pi_ver_t=1;
                for k=j:m
                    pi_ver_t=pi_ver_t*pi_hat_ver(i,k);
                end                    
                pi_ver(i,j,W+m-j+1)=pi_ver_t;
            end
        end
    end
end
% for i=1:height
%     for j=1:width
%         for k=-1*W:W
%             if (k == 0)
%                 pi_ver(j,i,W+1) = 0;
%             else
%                 pi_ver(j,i, k) =1;
%                 for n=k:j
%                     if (j+n >=1 && j+n<=width)
%                         pi_ver(j,i, k) = pi_ver(j, i, k) * pi_hat_ver(j+n,i);
%                     end
%                 end
%             end
%         end
%     end
% end
% 
%% 
pi_horizon = zeros(height,width, 2*W+1);
pi_vertical = zeros(height,width, 2*W+1);

for i=1:height
    for j=1:width
        for k=1:2*W+1
            pi_horizon(i,j,k)=pi_hor(i,j,k)/sum(pi_hor(i,j,:));
            pi_vertical(i,j,k)=pi_ver(i,j,k)/sum(pi_ver(i,j,:));
        end
    end
end
%% 

iteration = 1;
imageFiltered = noflash;

for n=1:iteration
    imageFilteredTemp = zeros(height,width,3);
    for i=1:height
        for j=1:width
            for k=-W:W
                if(j+k<=width && j+k>=1) 
                    imageFilteredTemp(i,j,:) = pi_horizon(i,j,k+W+1)*imageFiltered(i,j+k,:)+imageFilteredTemp(i,j,:);
                end
            end
            imageFilteredTemp(i,j,:) = imageFilteredTemp(i,j,:) + Lambda*pi_horizon(i,j,W)*(image(i,j,:) - imageFiltered(i,j,:));
            
        end
    end
    imageFiltered = imageFilteredTemp;
%     figure;
%     imshow(imageFiltered)
   
end
image = imageFiltered;
for n=1:iteration
    imageFilteredTemp = zeros(height,width,3);
    for i=1:height
        for j=1:width
            for k=-W:W
                if(j+k<=width && j+k>=1) 
                    imageFilteredTemp(i,j,:) = pi_horizon(i,j,k+W+1)*imageFiltered(i,j+k,:)+imageFilteredTemp(i,j,:);
                end
            end
            imageFilteredTemp(i,j,:) = imageFilteredTemp(i,j,:) + Lambda*pi_horizon(i,j,W)*(image(i,j,:) - imageFiltered(i,j,:));
            
        end
    end
    imageFiltered = imageFilteredTemp;
%     figure;
%     imshow(imageFiltered)
%    
end
     figure;
    imshow(imageFiltered)