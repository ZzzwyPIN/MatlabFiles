function [codebook,distortion]=VQ(training_seq,dimension,codebook_size,tolerance)
%VQ.m 	Vector quatizer design using K-means algorithm
%	[codebook,distortion]=VQ(training_seq,dimension,codebook_size,tolerance)
%	training_seq = training sequence
%	dimension = dimension of the quantizer
%	codebook_size = size of the codebook (rate=log2(codebook_size)/dimension)
%	tolerance = desired relative distortion (default=0.001)
%	Length of training_seq must be a multiple of the dimension of quantizer

if (nargin==3)
  tolerance=0.001;
end
m=round(length(training_seq)/dimension);
if (m*dimension-length(training_seq)<0)
  error('length of training_seq is not a multiple of dimension')
end
%	initialize the codebook
initial=training_seq(1:dimension*codebook_size);
initialcodebook=(reshape(initial,dimension,codebook_size))';
updated_codebook=initialcodebook;
%	first update
newdistortion=0;
distortion=0;
for i=1:m;
  training_seq_block=training_seq((i-1)*dimension+1:i*dimension);
  training_matrix(i,:)=training_seq_block;
  distortion_block=[ ];
  for j=1:codebook_size;
    distort=sum((training_seq_block-updated_codebook(j,:)).^2);
    distortion_block=[distortion_block distort];
  end
  [distortion_min,ind]=min(distortion_block);
  newdistortion=newdistortion+distortion_min;
  index(i)=ind;
end
for l=1:codebook_size;
  partition=(index==l);
  if sum(partition)>0
    updated_codebook(l,:)=partition*training_matrix/sum(partition);
  end
end
newdistortion=newdistortion/m;
%	furthur updated until the desired tolerance is met
while(abs(distortion-newdistortion)/newdistortion>tolerance)
  distortion=newdistortion;
  newdistortion=0;
  for i=1:m;
    training_seq_block=training_seq((i-1)*dimension+1:i*dimension);
    training_matrix(i,:)=training_seq_block;
    distortion_block=[ ];
    for j=1:codebook_size;
      distort=sum((training_seq_block-updated_codebook(j,:)).^2);
      distortion_block=[distortion_block distort];
    end
    [distortion_min,ind]=min(distortion_block);
    newdistortion=newdistortion+distortion_min;
    index(i)=ind;
  end
  for l=1:codebook_size;
    partition=(index==l);
    if sum(partition)>0
      updated_codebook(l,:)=partition*training_matrix/sum(partition);
    end
  end
  newdistortion=newdistortion/m;
end
codebook=updated_codebook;
distortion=newdistortion/dimension;