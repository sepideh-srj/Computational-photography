function res = method1(I, sizeOfPatch)
    
    numberOfPatches = 10;
    res = zeros(sizeOfPatch * numberOfPatches, sizeOfPatch*numberOfPatches, size(I,3));
    for i=1:numberOfPatches
        for j = 1:numberOfPatches
            randomX = randi([1, size(I,1) - sizeOfPatch ] ,1);
            randomY = randi([1, size(I,2) - sizeOfPatch ] ,1);
            indexX = (i-1)*sizeOfPatch+1;
            indexY = (j-1)*sizeOfPatch+1;
            patch =  I(randomX:randomX+sizeOfPatch, randomY:randomY+sizeOfPatch, :);
            res(indexX: indexX + sizeOfPatch, indexY: indexY + sizeOfPatch, :) = patch;
        end
    end
    imshow(res)




end