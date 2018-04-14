%% -- COUNT BITS USED -- %%
function bits = bitused(rbitstream,lbitstream)
    
    %% -- SEPARING INDICATORS -- %%
    k = [find(rbitstream == 'K') find(lbitstream == 'K')];
    h = [find(rbitstream == 'H') find(lbitstream == 'H')];
    r = [find(rbitstream == 'R') find(lbitstream == 'R')];
    
    %% -- COUNTING BITS -- %%
    bits = length(rbitstream)+length(lbitstream)-length(k)-length(h)-length(r);
end