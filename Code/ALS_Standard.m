%% -- CCAV PROJECT 1: ALS_STANDARD MPEG-4 -- %%
% -- This project performs a lossless audio coding using the paper given -- %

%% -- CLEARING MATLAB -- %%
clear all
close all
clc

%% -- AUDIO READING -- %%
path_mus = 'Musica';
mus = 'Work.flac';
os = input('(1) For Windows (2) For Macintosh: ');
switch os
	case 1
		path_code = '';
	otherwise
		path_code = '/Volumes/Productions/Alternas/UPC/4A/CCAV/CCAV_1/Code';
end
cd(path_mus);
[audio_signal,Fs] = audioread(mus,'native');
cd(path_code);

%% -- DECLARATION OF VARIABLES -- %%
frame_samples = 1024;
[frame_right,frame_left] = ALS_buffer(audio_signal,frame_samples);
[~,cols] = size(frame_right);
frame_dec_r = zeros(frame_samples,cols);
frame_dec_l = zeros(frame_samples,cols);

%% -- ITERATION THROUGH FRAMES -- %%
zero_frame = int16(zeros(frame_samples,1));
for j=1:cols
	%% -- CODER -- %%
	if(j == 1)
		[rbitstream] = ALS_Coder(zero_frame,frame_right(:,j));
		[lbitstream] = ALS_Coder(zero_frame,frame_left(:,j));
	else
		[rbitstream] = ALS_Coder(frame_right(:,j-1),frame_right(:,j)); 
		[lbitstream] = ALS_Coder(frame_left(:,j-1),frame_left(:,j));
    end
	%% -- DECODER -- %%
	if(j == 1)
		[frame_dec_r(:,j)] = ALS_Decoder(rbitstream,zero_frame);
		[frame_dec_l(:,j)] = ALS_Decoder(lbitstream,zero_frame);
	else
		[frame_dec_r(:,j)] = ALS_Decoder(rbitstream,frame_dec_r(:,j-1));
		[frame_dec_l(:,j)] = ALS_Decoder(lbitstream,frame_dec_l(:,j-1));
	end
end
frame_dec_r = int16(frame_dec_r);
frame_dec_l = int16(frame_dec_l);
%% -- RECONSTRUCTING AUDIO -- %%
output = audio_reconstructor(frame_dec_r,frame_dec_l);
filename = strcat('Dec_',mus);
audiowrite(filename,output,Fs);
