dataType = '';
addpath('dataset/COCO/coco/MatlabAPI');

mkdir('dataset/AI_challenge/mat')

annTypes = { 'instances', 'captions', 'coco_artkeypoint' };
annType=annTypes{3}; % specify dataType/annType

for mode = 0:1
    
    if mode == 0
        continue;
        dataType= 'validation';
        annFile=sprintf('dataset/AI_challenge/valid/%s_%s_annotations_20170911.json',annType,dataType);
    else
        dataType = 'train';
        annFile=sprintf('dataset/AI_challenge/train/%s_%s_annotations_20170909.json',annType,dataType);
    end
    
    coco=CocoApi(annFile);
    %%
    my_anno = coco.data.annotations;
    %%88153
    prev_id = -1;
    p_cnt = 1;
    cnt = 0;
    coco_kpt = [];
    
    for i = 1:1:size(my_anno,2)
        
        curr_id = my_anno(i).image_id;
        if(curr_id == prev_id)
            p_cnt = p_cnt + 1;
        else
            p_cnt = 1;
            cnt = cnt + 1;
        end
        if curr_id == 3873
            debug = 0;
        end
        coco_kpt(cnt).image_id = curr_id;
        coco_kpt(cnt).img_path = coco.loadImgs(curr_id).file_name;
        coco_kpt(cnt).annorect(p_cnt).bbox = my_anno(i).bbox;
        coco_kpt(cnt).annorect(p_cnt).segmentation = my_anno(i).segmentation;
        %coco_kpt(cnt).annorect(p_cnt).segmentation = 0;
        coco_kpt(cnt).annorect(p_cnt).area = my_anno(i).area;
        coco_kpt(cnt).annorect(p_cnt).id = my_anno(i).id;
        coco_kpt(cnt).annorect(p_cnt).iscrowd = my_anno(i).iscrowd;
        coco_kpt(cnt).annorect(p_cnt).keypoints = my_anno(i).keypoints;
        %coco_kpt(cnt).annorect(p_cnt).keypoints = my_anno(i).keypoint;
        coco_kpt(cnt).annorect(p_cnt).num_keypoints = my_anno(i).num_keypoints;
        coco_kpt(cnt).annorect(p_cnt).img_width = coco.loadImgs(curr_id).width;
        coco_kpt(cnt).annorect(p_cnt).img_height = coco.loadImgs(curr_id).height;
        %coco_kpt(cnt).annorect(p_cnt).neck = coco.data.neck(i);
        %coco_kpt(cnt).annorect(p_cnt).img_path = coco.loadImgs(curr_id).file_name
        prev_id = curr_id;
        
        fprintf('%d/%d \n', i, size(my_anno, 2));
    end
    %%
    if mode == 0
        coco_val = coco_kpt;
        save('dataset/AI_challenge/mat/coco_val.mat', 'coco_val');
    else
        save('dataset/AI_challenge/mat/coco_kpt.mat', 'coco_kpt');
    end
    
end
