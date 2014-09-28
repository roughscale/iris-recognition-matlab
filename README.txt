This repository contains the code for my 2013 RMIT Master of Computer Science research project on iris biometric recognition.

This code implements the IrisCode algorithm (Daugman) in MATLAB, extracts the IrisCode from the image set contained in the CASIA database and uses the Hamming Distance to identify an appropriate threshold for iris matching.  It performs the same process using the well-known Masek algorithm.

The original files submitted for the project assessment are not available, however the last available backup has been obtained.

This project has been reproduced with some slight bug fixes and modifications to the processing logic.


REQUIREMENTS

1. This code has been executed on MATLAB version R2014a. 
2. The images are located in the 'casia_images' directory.
3. There is a results directory (results2014)
4. The Masek algorithm has been installed in the masek directory.  The MATLAB implementation can be obtained from https://www.peterkovesi.com/studentprojects/libor/iriscode.zip

PROCESSING WORKFLOW

1. Generate iris code/template matrices:

   a. Run processiris4.m which process images with the Daugman algorithm and save iris code matrix in <IMG_NAME>.mat files

   b. Run processiris4_masek which process images with the Masek algorithm and saves the iris template matrix in <IMG_NAME>-masek.mat
   
2. Generate Hamming Distances of iris codes/templates

   a. Run processresults.m which processes the iris code matrix in the *.mat files and performs a HD comparison with all other .mat files to identify matches and writes the result to a text file (results5.txt)

   b. Run processresults_masek.m which processes the template matrix in the *-masek.mat files and performs a HD comparison with all other *-masek.mat files to identify matches and writes the result to a text file (results_masek.txt)
   
3. Generate Histograms of HD results.

   a. Run processresults2.m which loads the results5.txt file entries and generates histogram matrices (gen, imp) in the results.mat file.

   b. Run processresults2_masek which loads the results_masek.txt file entries and generates histogram matrices (gen, imp) in the masek_results.mat file.
   
4. Generate Hamming Distances of iris codes/templates with same subject.

   a. Run processsameresults.m which loads the iriscode2 matrix from the *.mat file and does a HD comparison against all other .mat files for the same subject to identify same eye or different eye and writes the results to a text file (same-results.txt)

   a. Run processsameresults_masek.m which loads the template matrix from the *-masek.mat file and does a HD comparison against all other *-masek.mat files for the same subject to identify same eye or different eye and writes the results to a text file (same-results-masek.txt)

5. Generate Histograms of same subject HD results:

   a. Run results_gen.m which loads the same-results.txt file and generates histogram matrices (same, diff) in the gen_results.mat file.

   b. Run results_gen_masek.m which loads the masek-same-results.txt file and generates histogram matrices (same, diff) in the masek_gen_results.mat file.
   
6. Generate Histogram plot images

   a. Run plotresults.m which loads the same and diff matrics from the gen_results.mat file and the imp matrix from the results.mat file and generates images of the histograms (hd-genuine.png, hd-imposter.png, hd-genuine-same.png, hd-genuine-diff.png)

   b. Run plotresults_masek.m which loads the same and diff matrices from the masek_gen_results.mat file and the imp matrix from the masek_results.mat file and generates images of the histograms (masek-hd-genuine.png, masek-hd-imposter.png, masek-hd-genuine-same.png, masek-hd-genuine-diff.png)

7. Generate ROC image

   a. Run plotroc.m which loads the matrices from the results.mat and gen_results.mat files, calculates the FAR and FRR scores, saves this to plotroc.mat file, generates a ROC image plotting the FAR and FAR curves, and calculates the EER.

   a. Run plotroc_masek.m which loads the matrices from the masek_results.mat and masek_gen_results.mat files, calculates the FAR and FRR scores, saves this to plotroc_masek.mat file, generates a ROC image plotting the FAR and FAR curves, and calculates the EER.
