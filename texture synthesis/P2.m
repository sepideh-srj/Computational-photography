texture = imread("p3data/textures/toast.png");
Image = imread("p3data/images/ml.jpg");
Image = im2double(Image);
texture = im2double(texture);


patch = 30;
overlap = 10;
alpha = 0.8;
trans = transfer(texture, Image, overlap, patch, alpha);