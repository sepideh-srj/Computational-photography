function  output = imblend( source, mask, target, transparent )
%Source, mask, and target are the same size (as long as you do not remove
%the call to fiximages.m). You may want to use a flag for whether or not to
%treat the source object as 'transparent' (e.g. taking the max gradient
%rather than the source gradient).
[rows, cols, ~] = size(mask);
A = sparse(rows*cols, rows*cols);

B = zeros(rows*cols, 3);
mask = padarray(mask,[1,1]);
source = padarray(source,[1,1],'replicate');
target = padarray(target,[1,1],'replicate');
for i=1:rows
    for j=1:cols
        row = (j-1)*rows + i;
        col = (j-1)*rows+i;
        if (mask(i,j) == 0)
            A(row, col) = 1;
            B(row,:) = target(i,j,:);
        else
           counter = 0;
           if (col-1 >= 1)
               counter = counter + 1;
               A(row, col - 1) = -1;
               B(row,:) = B(row,:) + reshape((source(i,j,:) - source(i,j-1,:)),[1,3]);
           end
           if (col+1 <= cols*rows)
               A(row, col + 1) = -1;
               counter = counter + 1;
               B(row,:) = B(row,:) +reshape((source(i,j,:) - source(i,j+1,:)),[1,3]);
           end
           if (rows+col <= rows*cols)
               A(row, col + rows) = -1;
               counter = counter + 1;
               B(row,:) = B(row,:) + reshape((source(i,j,:) - source(i+1,j,:)),[1,3]);
           end
           if (col-rows >= 1)
               A(row, col - rows) = -1;
               counter = counter + 1;
               B(row,:) = B(row,:) + reshape((source(i,j,:) - source(i-1,j,:)),[1,3]);
           end
%            counter
           A(row, col) = counter;

%            if (mask(i-1,j) == 0)
%    
%                B(row,:) = B(row,:) + reshape(source(i-1,j,:),[1,3]);
%            end
%            if (mask(i+1,j) == 0)
%                B(row,:) = B(row,:) + reshape(source(i+1,j,:),[1,3]);
%            end
%            if (mask(i,j-1) == 0)
%                B(row,:) = B(row,:) + reshape(source(i,j-1,:),[1,3]);
%            end
%            if (mask(i,j+1) == 0)
%                B(row,:) = B(row,:) + reshape(source(i,j+1,:),[1,3]);
%            end
        end
    end
end
%Ax = B
x = A\B;
x = reshape(x, [rows, cols, 3]);
imshow(x)

output = x;
end 


%output = source .* mask + target .* ~mask;


