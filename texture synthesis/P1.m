names = ["apples.png", "brick.jpg", "grass.png", "radishes.jpg", "random.png", "random3.png", "rice.bmp", "text.jpg", "toast.png", "weave.jpg"];

for i =3:3
    I = imread('p3data/textures/' +  names(i));
    I = im2double(I);   
    sizeOfPatch = 50;
    sizeOfOverlap = 5;
%     Image = method1(I,100);
    Image2 = method3(I, sizeOfPatch, sizeOfOverlap);
    name ="method2-" + names(i)+"-" + sizeOfPatch + "-" + sizeOfOverlap;
    imwrite(Image2, name+".jpg");
% Image3 = method3(I, sizeOfPatch, sizeOfOverlap);

end