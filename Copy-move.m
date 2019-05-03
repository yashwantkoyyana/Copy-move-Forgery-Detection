clc
close all;
clear all;


tic
srcFiles = dir('C:\Users\yash\Pictures\test\*.jpg');  
path='C:\Users\yash\Pictures\test1';
path2='C:\Users\yash\Pictures\test2';
for i = 1 : length(srcFiles)

    filename = strcat('C:\Users\yash\Pictures\test\',srcFiles(i).name);
    i1 = imread(filename);
    i1=rgb2gray(i1);
    i2= imresize(i1,[64 64]);
   
 
figure, imshow(i2); title('Original');
%.........RANDOM COPY MOVE...........................................
N = 1 ;
a = 0;
b = 20;
r = round((b-a).*rand(N,1) + a);
r;
s=r+15;
s;
i3=i2(r:s,r:s);
i4=i3+10;
i2(s+15:s+30,s+15:s+30)= i4;
fol=zeros(64,64);

   
    fol(s+15:s+30,s+15:s+30)=1;
    fol(r:s,r:s) =1;

    

figure,imshow(i2);title('Copy-moved');
%..........STORING IN A FOLDER................................
baseFileName = sprintf('%d.png', i); 
    fullFileName = fullfile(path, baseFileName); 
    imwrite(fol,fullFileName);
    
[row, col]= size(i2);
%i2=im2double(i2);


counti=0;
countj=0;
% S=zeros(1,2);
% add2=zeros(size(S));
%................OVERLAPPING BLOCKS.............................
Blocks2 = cell(row/8,col/8);
for x=1:row-7
    counti = counti + 1;
    countj = 0;
    for j=1:col-7
        
        countj = countj + 1;
        Blocks2{counti,countj} = i2(x:x+7,j:j+7);   
    end                                              
end

 %...................Subtract each block with every other block.......  
output=zeros(64,64);                      
for y= 1:57
    for j=1:57
         A2=Blocks2{y,j};
%         [row1, col1]= size(A2);                       
        for k=y+1:57                                  
            for L=j+1:57 
                A3= Blocks2{k,L};
                            Z= A3-A2;
                            Z(A3 == 255)= max(Z(:));
                            if all(Z > 0)
                            if all(Z == Z(1))
                                output(y:y+7,j:j+7)=1;        
                                output(k:k+7,L:L+7)=1;
                            end
                            end
             end
         end
    end
end
       
       figure,imshow(output);
       title('output'); 
       baseFileName = sprintf('%d.png', i); 
       fullFileName = fullfile(path2, baseFileName); 
       imwrite(output,fullFileName);
       
end
 %.........................COMPARISION.................................................
     first_dir = 'C:\Users\yash\Pictures\test1';
second_dir = 'C:\Users\yash\Pictures\test2';
fileList1 = dir(fullfile(first_dir, '*.png'));
fileList2 = dir(fullfile(second_dir, '*.png'));
numFiles1 = length(fileList1);
numFiles2 = length(fileList2);
baseFileNames1 = {fileList1.name}';
baseFileNames2 = {fileList2.name}';
for I1 = 1:numFiles1
	firstBaseName = baseFileNames1{I1};
	firstFullFileName = fullfile(first_dir, firstBaseName);
	image1 = imread(firstFullFileName);
	
		secondBaseName = baseFileNames2{I1};
		secondFullFileName = fullfile(second_dir, secondBaseName);
		image2 = imread(secondFullFileName);
		if isequal(size(image1), size(image2))
			compare_images = imabsdiff(image1,image2);
			% Sizes match.  Subtract them and display the differences.
			figure;
			imshow(compare_images);
            
			title( sprintf('"%s" vs "%s"', secondBaseName, firstBaseName) );
			
            A=nnz(compare_images);
            FP=(A/64)*100


           if compare_images==zeros(64,64);
               fprintf(' accuracy is 100%./n')
           else
           end
			% Sizes do NOT match.  Print out that they don't match, then continue.
		end
end


sprintf('\n')
