function opts = get_opts_aic()

addpath(genpath('src'))

opts = [];
opts.dataset = 2;%0 for duke, 1 for mot, 2 for aic
opts.feature_dir     = [];
opts.dataset_path    = 'D:/Data/AIC19';
opts.gurobi_path     = 'C:/Utils/gurobi801/win64/matlab';
opts.experiment_root = 'experiments';
opts.experiment_name = 'aic_demo';
[opts.projection,opts.fisheye_mapping] = get_projection_param(opts);

opts.reader = MyVideoReader_aic(opts.dataset_path);

% General settings
opts.eval_dir = 'L3-identities';
opts.visualize = false;
opts.image_width = 1920;
opts.image_height = 1080;
opts.current_camera = -1;
opts.minimum_trajectory_length = 4;
opts.optimization = 'KL'; 
opts.sequence = 1;
opts.sequence_names = {'train_134', 'test_6', 'test_2', 'test_5', 'test_26','test_25','train_34','train_1'};
opts.seqs = {[1,3,4],6,2,5,[2,6],[2,5],[3,4],1};
opts.folder_by_scene = {'train', 'test','train', 'train','test','test'};
opts.folder_by_seq = {'train', 'test', 'test', 'test', 'test', 'test','train', 'train'};
opts.cams_in_scene = {1:5,6:9,10:15,16:40,[10,16:29,33:36],[22:28,33:35]};
opts.subscenes = {{1:5},{6:9},{10:15},{16:17,18:21,22:26,27:28,29:32,33:36,37:40},{[10,16,17],18:21,22:26,27:28,29,33:36},{27:28,33:35}};
opts.sub_dir = {'train', 'test', 'test', 'test', 'test', 'test', 'train', 'train'};
opts.current_scene = -1;
opts.render_threshold = -10;
opts.load_tracklets = 1;
opts.load_trajectories = 1;
opts.appear_model_name = 'AIC_ensemble/gt_10fps/model_param_L2_50.mat';
opts.soft = 0.1;
opts.fft = false;
opts.fps = 10;
opts.frame_offset = get_frame_offset(opts);
opts.world_center = {[42.525678, -90.723601],[42.491916, -90.723723],[42.498780, -90.686393],[42.498780, -90.686393],[42.498780, -90.686393]};
opts.world_scale = 6371000/180*pi;
opts.detections = 'ssd512';
opts.static_speed = 6/3.6;


% Tracklets
tracklets = [];
tracklets.spatial_groups = 1;
tracklets.window_width = 10;
tracklets.min_length = 2;
tracklets.alpha = 0;
tracklets.beta = 0.02;
tracklets.cluster_coeff = 0.75;
tracklets.nearest_neighbors = 8;
tracklets.speed_limit = 180/3.6;
tracklets.threshold = 8;
tracklets.diff_p = 0;
tracklets.diff_n = 0;
tracklets.step = false;
tracklets.og_appear_score = true;
tracklets.og_motion_score = true;
tracklets.less_smooth_cams = [16,17,29];


% Trajectories
trajectories = [];
trajectories.appearance_groups = 0; % determined automatically when zero
trajectories.alpha = 0;
trajectories.beta = 0.001;
trajectories.window_width = 30;
trajectories.speed_limit = 150/3.6;
trajectories.indifference_time = 20;
trajectories.threshold = 8;
trajectories.diff_p = 0;
trajectories.diff_n = 0;
trajectories.step = false;
trajectories.og_appear_score = true;
trajectories.og_motion_score = true;
trajectories.use_indiff = true;
trajectories.smoothness_interval_length = 4;
trajectories.weightSmoothness = 0;
trajectories.weightVelocityChange = 0;
trajectories.weightDistance = 0;
trajectories.weightShapeChange = 0;
trajectories.weightIOU = 0;
trajectories.allow_acute_cams = [7,8,10];
trajectories.less_smooth_cams = [16,17,29];

% Identities
identities = [];
identities.window_width = [200,200];
identities.appearance_groups = 0; % determined automatically when zero
identities.alpha = 0;
identities.beta = 0.01;
identities.speed_limit = [80,10]/3.6;
identities.allow_acute_cams = [2,5,7,8,10];
identities.indifference_time = 1000;
identities.threshold = 8;
identities.diff_p = 0;
identities.diff_n = 0;
identities.optimal_filter = true;
identities.step = false;
identities.extract_images = true;
identities.og_appear_score = true;
identities.og_motion_score = true;
identities.smoothness_interval_length = 4;
identities.weightSmoothness = 0;
identities.weightVelocityChange = 0;
identities.weightDistance = 0;
identities.weightShapeChange = 0;
identities.weightIOU = 0;

opts.tracklets = tracklets;
opts.trajectories = trajectories;
opts.identities = identities;
end

