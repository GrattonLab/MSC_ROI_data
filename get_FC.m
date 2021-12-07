clear all
close all
clc

% IndParcels_Gordon2017_Neuron

x = load('IndParcels_Gordon2017_Neuron/Rest/MSC01_parcel_timecourse.mat');
y = load('IndParcels_Gordon2017_Neuron/Memory/MSC01_parcel_timecourse.mat');
coor = dlmread('IndParcels_Gordon2017_Neuron/MSC01_parcel_centroids_Talaraich.txt');

% x = load('GroupParcels_333Gordon2016_CerebralCortex/Rest/MSC01_parcel_timecourse.mat');
% y = load('GroupParcels_333Gordon2016_CerebralCortex/Memory/MSC01_parcel_timecourse.mat');

tsx = [];
tsy = [];
ix = [];
iy = [];
gam = 0.75;
for i = 1:length(x.parcel_time)
    tsx = [tsx; zscore(x.parcel_time{i}(x.tmask_all{i} > 0,:))];
    tsy = [tsy; zscore(y.parcel_time{i}(y.tmask_all{i} > 0,:))];
    ix = [ix; ones(sum(x.tmask_all{i}),1)*i];
    iy = [iy; ones(sum(y.tmask_all{i}),1)*i];
    
    xx = x.parcel_time{i};
    yy = y.parcel_time{i};
    tx = x.tmask_all{i} > 0;
    ty = y.tmask_all{i} > 0;
    
    xx = xx(tx,:);
    yy = yy(ty,:);
    nx = sum(tx);
    ny = sum(ty);
    
    
    dd = min(nx,ny);
    
    xxx(:,:,i) = corr(xx(1:dd,:));
    yyy(:,:,i) = corr(yy(1:dd,:));
end

% hx = hist(ix,1:max(ix));
% hy = hist(iy,1:max(iy));
% mn = min(hx,hy);
% 
% jx = zeros(size(ix));
% jy = zeros(size(iy));
% for i = 1:length(mn)
%     idx = find(ix == i);
%     idy = find(iy == i);
%     idx = idx(1:mn(i));
%     idy = idy(1:mn(i));
%     jx(idx) = 1;
%     jy(idy) = 1;
% end
% 
% tsx = tsx(jx > 0,:);
% tsy = tsy(jy > 0,:);
% rhox = corr(tsx);
% rhoy = corr(tsy);
% 
% b = rhoy - rhox;