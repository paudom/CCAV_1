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

%% -- INITIALIZATING STATES -- %%
rstate = [];lstate = [];
rdstate = [];ldstate = [];

for j=1:cols
	%% -- CODER -- %%
	[rbitstream,frstate] = ALS_Coder(frame_right(:,j),rstate,j); rstate = frstate;
	[lbitstream,flstate] = ALS_Coder(frame_left(:,j),lstate,j); lstate = flstate;
	
	%% -- DECODER -- %%
	if(j == 1)
        zero_frame = int16(zeros(frame_samples,1));
		[frame_dec_r(:,j),frdstate] = ALS_Decoder(rbitstream,rstate,zero_frame); rdstate = frdstate;
		[frame_dec_l(:,j),fldstate] = ALS_Decoder(lbitstream,lstate,zero_frame); ldstate = fldstate;
	else
		[frame_dec_r(:,j),frdstate] = ALS_Decoder(rbitstream,rstate,frame_dec_r(:,j-1)); rdstate = frdstate;
		[frame_dec_l(:,j),fldstate] = ALS_Decoder(lbitstream,lstate,frame_dec_l(:,j-1)); ldstate = fldstate;
	end
end
%% -- RECONSTRUCTING AUDIO -- %%
output = audio_reconstructor(frame_dec_r,frame_dec_l);
filename = strcat('Dec_',mus);
audiowrite(filename,output,Fs);
