%% -- CCAV PROJECT 1: ALS_STANDARD MPEG-4 -- %%
% -- This project performs a lossless audio coding using the paper given -- %

%% -- CLEARING MATLAB -- %%
clear all
close all
clc

%% -- AUDIO READING -- %%
mus = 'Work.flac';
audio_signal = audioread(mus,'native');
audio_struct = audioinfo(mus);

%% -- DECLARATION OF VARIABLES -- %%
frame_samples = 1024;
[frame_right,frame_left] = ALS_buffer(audio_signal,frame_samples);

%% -- ITERATION THROUGH FRAMES -- %%

%% -- INITIALIZATING STATES -- %%
rstate = 0;lstate = 0;
%% -- CODER -- %%
[rbitstream,frstate] = ALS_Coder(frame_right(:,1),rstate);
[lbitstream,flstate] = ALS_Coder(frame_left(:,1),lstate);

%% -- DECODER -- %%
frame_dec_r = ALS_Decoder(rbitstream);
frame_dec_l = ALS_Decoder(lbitstream);

%% -- PLOTTING -- %%
plotting_audios(audio_signal,audio_output); 