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
audio_signal = audioread(mus,'native');
audio_struct = audioinfo(mus);
cd(path_code);

%% -- DECLARATION OF VARIABLES -- %%
frame_samples = 1024;
[frame_right,frame_left] = ALS_buffer(audio_signal,frame_samples);
[~,cols] = size(frame_right);
frame_dec_r = zeros(frame_samples,cols);
frame_dec_l = zeros(frame_samples,cols);

%% -- ITERATION THROUGH FRAMES -- %%

%% -- INITIALIZATING STATES -- %%
rstate = 0;lstate = 0;

%% -- CODER -- %%
[rbitstream,frstate] = ALS_Coder(frame_right(:,1),rstate);
[lbitstream,flstate] = ALS_Coder(frame_left(:,1),lstate);

%% -- DECODER -- %%
frame_dec_r(:,1) = ALS_Decoder(rbitstream);
frame_dec_l(:,1) = ALS_Decoder(lbitstream);

%% -- RECONSTRUCTING AUDIO -- %%

%% -- PLOTTING -- %%
plotting_audios(audio_signal,audio_output); 