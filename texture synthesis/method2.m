function res2 = method2(I, sizeOfPatch, sizeOfOverlap)

    numberOfPatches = 10;
    res = zeros(sizeOfPatch * numberOfPatches, sizeOfPatch*numberOfPatches, size(I,3));
    numCandid = 20;
    for i=1:numberOfPatches
        startRow = true;
        for j = 1:numberOfPatches
            indexX = (i-1)*sizeOfPatch+1;
            indexY = (j-1)*sizeOfPatch+1;
            if (startRow == true)
                randomX = randi([1, size(I,1) - sizeOfPatch ] ,1);
                randomY = randi([1, size(I,2) - sizeOfPatch ] ,1);

                patch =  I(randomX:randomX+sizeOfPatch, randomY:randomY+sizeOfPatch, :);
            else
                candids = zeros(numCandid,2);
                errors = ones(numCandid,1)*10000;
                for x=1:size(I,1)-sizeOfPatch
                    for y = 1:size(I,2) - sizeOfPatch
                        ssd = (res(indexX:indexX+sizeOfPatch-1, indexY-(j-1)*sizeOfOverlap:indexY-(j-1)*sizeOfOverlap+sizeOfOverlap, :) - I(x:x+sizeOfPatch-1, y:y+sizeOfOverlap, :)).^2;
                        ssd = sum(sum(sum(ssd)));
                        for n = 1:numCandid
                            if (ssd < errors(n))
                                errors(n) = ssd;
                                candids(n, :) = [x, y];
                                for u=numCandid:-1:n+1
                                    errors(u) = errors(u-1);
                                    candids(u, :) = candids(u-1, :);
                                end
                                break;
                            end
                        end
                    end
                end
%                 candids
           randCand = randi([1, numCandid] ,1);
           patch =  I(candids(randCand,1):candids(randCand,1)+sizeOfPatch, candids(randCand,2):candids(randCand,2)+sizeOfPatch, :);
           res2(indexX: indexX + sizeOfPatch, indexY: indexY + sizeOfPatch, :) = patch;
 
            end
            res2(indexX: indexX + sizeOfPatch, indexY: indexY + sizeOfPatch, :) = patch;
            startRow = false;
        end
    end
    imshow(res2)






end