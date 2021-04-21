function res3 = method3(I, sizeOfPatch, sizeOfOverlap)
% I = imread('p3data/textures3/apples.png');
% 
% I = im2double(I);
% sizeOfPatch = 90;
% sizeOfOverlap = 15;
    numberOfPatches = 10;
    res3 = zeros(sizeOfPatch * numberOfPatches, sizeOfPatch*numberOfPatches, size(I,3));
    numCandid = 10;
    for i=1:numberOfPatches
        startRow = true;
        for j = 1:numberOfPatches
            indexX = (i-1)*sizeOfPatch+1;
            indexY = (j-1)*sizeOfPatch-(j-1)*sizeOfOverlap+1;
            if (startRow == true)
                randomX = randi([1, size(I,1) - sizeOfPatch ] ,1);
                randomY = randi([1, size(I,2) - sizeOfPatch ] ,1);

                patch =  I(randomX:randomX+sizeOfPatch, randomY:randomY+sizeOfPatch, :);
                res3(indexX: indexX + sizeOfPatch, indexY: indexY + sizeOfPatch, :) = patch;

            else
                candids = zeros(numCandid,2);
                errors = ones(numCandid,1)*10000;
                for x=1:size(I,1)-sizeOfPatch+1
                    for y = 1:size(I,2) - sizeOfPatch+1
                        ssd = (res3(indexX:indexX+sizeOfPatch-1, indexY:indexY+sizeOfOverlap, :) - I(x:x+sizeOfPatch-1, y:y+sizeOfOverlap, :)).^2;
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
           randCand = randi([1, numCandid] ,1);
           
           DP = res3(indexX:indexX+sizeOfPatch-1, indexY:indexY+sizeOfOverlap, :) - I(candids(randCand,1):candids(randCand,1)+sizeOfPatch-1, candids(randCand,2):candids(randCand,2)+sizeOfOverlap, :);
           DP = sum(DP.^2,3);
           cand_x = candids(randCand,1);
           cand_y = candids(randCand,2);
           for i_dp=2:sizeOfPatch
               for j_dp=1:sizeOfOverlap+1
                   minD = DP(i_dp-1,j_dp);
                   if j_dp > 1
                        minD = min(minD, DP(i_dp-1, j_dp-1));
                   end
                    if j_dp < sizeOfOverlap+1
                        minD = min(minD, DP(i_dp-1, j_dp+1));
                    end
                   DP(i_dp,j_dp) = minD + DP(i_dp,j_dp);
               end
           end
          [val, ind] = min(DP(sizeOfPatch, :));
          res3(indexX + sizeOfPatch-1, indexY+ind-1: indexY + sizeOfPatch-1, :)= I(cand_x+sizeOfPatch-1, cand_y+ind-1:cand_y+sizeOfPatch-1, :);
                for i_x = sizeOfPatch-1:-1:1
                    mn = DP(i_x, ind);
                    if ind > 1 && DP(i_x, ind-1) < mn
                        ind = ind-1;
                    end
                    if ind < sizeOfOverlap+1 && DP(i_x, ind+1) < mn
                        ind = ind + 1;
                    end
                    res3(indexX+i_x-1, indexY+ind-1:indexY+sizeOfPatch-1, :) = I(cand_x+i_x-1, cand_y+ind-1:cand_y+sizeOfPatch-1, :);
                end
            
                       
            end
            
            startRow = false;
        end
    end
    figure;
    imshow(res3)






end