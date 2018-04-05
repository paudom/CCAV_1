%% -- CCAV PROJECT 1: ALS_STANDARD MPEG-4 -- %%
% -- This project performs a lossless audio coding using the paper given -- %

%% -- CLEARING MATLAB -- %%
clear all
close all
clc

%% -- DEFINING PATHS -- %%
os = input('Please select "1" for WINDOWS and "2" for MACINTOSH');

switch os
	case 1
		%% -- WINDOWS -- %%
		path_code='C:\Users\Maria\Documents\UNIVERSITAT\4A\CCAV\PROJ1\CCAV_1\Code';
		path_mus='C:\Users\Maria\Documents\UNIVERSITAT\4A\CCAV\PROJ1\CCAV_1\Musica\Work.flac';
	case 2
		%% -- MACINTOSH -- %%
		path_code='/Volumes/Productions/Alternas/UPC/4A/CCAV/CCAV_1/Code';
		path_mus='/Volumes/Productions/Alternas/UPC/4A/CCAV/CCAV_1/Musica/Work.flac';
end

%% -- AUDIO READING -- %%
audio_signal = audioread(path_mus,'native');
audio_struct = audioinfo(audio_signal);

%% -- CODER -- %%
bitstream = ALS_Coder(audio_signal,audio_struct);

%% -- DECODER -- %%
[audio_output,audio_out_struct] = ALS_Decoder(bitstream);

%% -- PLOTTING -- %%
plotting_audios(audio_signal,audio_output); 