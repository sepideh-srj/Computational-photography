# Computational Photography

## Overview
This repository focuses on fundamental research topics in computational photography and image manipulation implemented in MATLAB.

## Projects
1. **Iterative Edge-Aware Filtering and Cross Filtering** 

   Objective: Edge-aware filters use the edges (sharp transitions) of one image (the guide image) to filter another image. This method is often applied for denoising images. In this task, we will denoise no-flash photographs using their flash counterparts as guides.
   
3. **Poisson Blending**

    Objective: Seamlessly blend a source image into a target image by preserving gradients rather than absolute intensities.
  
    Method: Poisson blending solves a second-order partial differential equation (Poisson's equation) to maintain the gradient of the source image while integrating it into the target image.
   Here are the results of the Poisson blending:
    
    <img width="165" alt="image" src="https://github.com/sepideh-srj/Computational-photography/assets/12370175/3190143a-20b5-4652-b8dd-36e9cdad7397">
    
    <img width="609" alt="image" src="https://github.com/sepideh-srj/Computational-photography/assets/12370175/cd055000-20e6-4cc4-85fd-964bb715a801">
    
    <img width="497" alt="image" src="https://github.com/sepideh-srj/Computational-photography/assets/12370175/db0ce005-efaf-4a10-9114-c938cb292ad3">

4. **Texture** 
- Part 1: Texture synthesis

  Objective: Sample patches from an input texture and compose them overlapping to generate a larger texture.
  
  Method 1: Randomly select patches, leading to noticeable edges due to mismatched overlaps.

  Method 2: Find a patch with some agreement with overlapping regions (small SSD error).  

  Method 3: Use dynamic programming to find a minimum error cut in the overlapping region, similar to seam carving.
  
  Here is a text synthesis with patch size of 100 and overlap of 10:
  
  <img width="473" alt="image" src="https://github.com/sepideh-srj/Computational-photography/assets/12370175/c0084af9-a3ba-48e6-aebb-4bd5f2fdc380">


- Part 2: Texture Transfer
  
  Objective: Re-render an image in the style of another texture.
  The texture of bread transformed:   
  <img width="395" alt="image" src="https://github.com/sepideh-srj/Computational-photography/assets/12370175/be2f3c7e-c60f-43f2-85a3-ff163d1ebf05">





## Getting Started
To use these projects, clone the repository and open the files in MATLAB. 
