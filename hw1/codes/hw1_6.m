clc; clear;

watch = imread('watch.tif');
watch_correct = watch(: , : ,1);;

%% image shrinking by nearest approach
watch_shrink_nearest = imresize( watch_correct , 0.2 , 'nearest');
zoomback_watch_shrink_nearest = imresize( watch_shrink_nearest , 5);
subplot(1,3,1),imshow(zoomback_watch_shrink_nearest),title('nearest');

%% image shrinking by bilinear approach
watch_shrink_bilinear = imresize( watch_correct , 0.2 , 'bilinear');
zoomback_watch_shrink_bilinear = imresize( watch_shrink_bilinear , 5);
subplot(1,3,2),imshow(zoomback_watch_shrink_bilinear),title(' bilinear');

%% image shrinking by bicubic approach
watch_shrink_bicubic = imresize( watch_correct , 0.2 , 'bicubic');
zoomback_watch_shrink_bicubic = imresize( watch_shrink_bicubic , 5 );
subplot(1,3,3),imshow(zoomback_watch_shrink_bicubic),title('bicubic');