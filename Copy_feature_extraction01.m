close all;
clear all;
clc;
im=gpuArray(imread ('C:\Users\Prash\Desktop\test1.png'));
I=rgb2gray(im);
% I=imresize(I,[128,128]);
%imshow(I);
row=size(I,1);
col=size(I,2);
B=input('Enter the block size');
nob=(row-B+1)*(col-B+1);
a=[B,B,nob];
f=[];
c=[];
d=[];
X=[]; 
s=25;
k=1;
u=1;
%imshow(is);                                                         
%------------- OVERLAPPING BLOCKS----------------------
for i=1:row-B
    for j=1:col-B
        
        for h=i:i+B-1
            for v=j:j+B-1
                a(h,u,k)=I(h,v);
                u=u+1;
            end
            u=1;
        end

        k=k+1;
        
    end
    
end


%---------------FINDING MEAN----------------------
    
for i=1:k-1
     
    f(i)= mean(mean(a(:,:,i)));
     
     
   
     
end
%---------------STORING THE BLOCKS INTO CELLS---------------
C=cell(1,16);
%disp(size(C));
%disp(C);
 
for i=1:16
    x=1;
    w=[];
    for j=1:k-1 
   
    n=f(j)/16;
    n=floor(n);
    if (i==n)
        w(x)=j;
        x=x+1;
        
    end
    
    end
    %disp(w);
      
    C{1,i} =w;
   
end
 %  disp(C);
 
 
 %disp(C{1,2});
 %---------------FEATURE EXTRACTION && DISTANCE MATRIX--------------------------------
p=1;
D=[nob,nob,1];

 for s=1:16
  for i=1:size(C{1,s},2)
     for j=i:size(C{1,s},2) 
    
        x=C{1,s}(i);
        y=C{1,s}(j);
        F1=(a(:,:,x));
        F2=dct(a(:,:,y));
        D(x,y) = F1-F2;
       
            
        
    
      end
    
     
 
   end 
end
 disp(D);
%  sp=cell(1,1500);
h=1;
u=[];
 for i=1:size(D,1)
     
     for j=1:size(D,2)
         
         if(D(i,j)<0.4)
             if (D(i,j)>0)
               u(h)=i;
               h=h+1;
               u(h)=j;
               h=h+1;
             end
         end 
     end 
 end 
 %disp(u);

 u = int64(u);
%u=unique(u);
%disp(u);
 %---------------REMOVING FALSE POSITIVES-------------------
 for i=1:(size(u,2)/2)
     
      j=2*i-1;
      k=j+1;
      x =abs(u(j)-u(k));
      if (x<20)
          u(j)=0;
          u(k)=0;
        
      end
          
 end
u=unique(u);
disp(u);
%  y=[];
%  for i=1:size(u)-1
%      y(i)=u(i+1);
%  end
%       u(i)=x;
%      
%     
%          
%         u(j)=y
%        
%            
%  end 
%  
 
 

 %------------PROJECTING INTO MAIN MATRIX OF BLOCKS---------
for n=2:size(u,2)
    z=u(n);
    if (mod(z,row-B+1)==0)
         s=z/(row-B+1);
    
    else
     s=z/(row-B+1);
     s=floor(s);
     s=s+1;
        
    end
%     s=z/(row-B+1);
%     s=floor(s);
%     s=s+1;
    if (mod(z,col-B+1)==0)
        co=z;
        
    else
     co=mod(z,col-B+1);
%      co=co+1; 
    end 
%     co=mod(z,col-B+1);
%     co=co+1;    
    for i=s:s+B-1
        for j=co:co+B-1
            I(i,j)=0;
            
    
        end
    end
                
  
 end
 %.....................Output......................................
 imshow(I);
 %imshow(histeq(imresize(I,[128,128])));
 
 
 

