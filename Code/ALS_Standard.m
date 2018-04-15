%% -- CCAV PROJECT 1: ALS_STANDARD MPEG-4 -- %%
% -- This project performs a lossless audio coding using the paper given -- %

%% -- CLEARING MATLAB -- %%
clear all
close all
clc

%% -- AUDIO READING -- %%
path_mus = 'Musica';
mus = 'Woo_1.flac';
path_code = '/Volumes/Productions/Alternas/UPC/4A/CCAV/CCAV_1/Code';
cd(path_mus);
[audio_signal,Fs] = audioread(mus,'native');
audio_struct = audioinfo(mus);
BitsAudio = audio_struct.BitsPerSample*audio_struct.TotalSamples*audio_struct.NumChannels;
cd(path_code);

%% -- DECLARATION OF VARIABLES -- %%
frame_samples = 1024;
[frame_right,frame_left] = ALS_buffer(audio_signal,frame_samples);
[~,cols] = size(frame_right);
frame_dec_r = zeros(frame_samples,cols);
frame_dec_l = zeros(frame_samples,cols);

%% -- ITERATION THROUGH FRAMES -- %%
zero_frame = int16(zeros(frame_samples,1));
w = hamming(frame_samples);
t_com = zeros(cols,1);
t_decom = zeros(cols,1);
BitsUsed = 0;

for j=1:cols
	%% -- CODER -- %%
    tic
	if(j == 1)
		[rbitstream] = ALS_Coder(zero_frame,frame_right(:,j),w);
		[lbitstream] = ALS_Coder(zero_frame,frame_left(:,j),w);
	else
		[rbitstream] = ALS_Coder(frame_right(:,j-1),frame_right(:,j),w); 
		[lbitstream] = ALS_Coder(frame_left(:,j-1),frame_left(:,j),w);
    end
    t_com(j)=toc;
    BitsUsed = BitsUsed + bitused(rbitstream,lbitstream);
	%% -- DECODER -- %%
    tic
	if(j == 1)
		[frame_dec_r(:,j)] = ALS_Decoder(rbitstream,zero_frame);
		[frame_dec_l(:,j)] = ALS_Decoder(lbitstream,zero_frame);
	else
		[frame_dec_r(:,j)] = ALS_Decoder(rbitstream,frame_dec_r(:,j-1));
		[frame_dec_l(:,j)] = ALS_Decoder(lbitstream,frame_dec_l(:,j-1));
    end
    t_decom(j) = toc;
end
frame_dec_r = int16(frame_dec_r);
frame_dec_l = int16(frame_dec_l);
%% -- RECONSTRUCTING AUDIO -- %%
output = audio_reconstructor(frame_dec_r,frame_dec_l);
filename = strcat('Dec_',mus);
audiowrite(filename,output,Fs);
C = (BitsUsed/BitsAudio)*100;
total_com = sum(t_com);
total_decom = sum(t_decom);
