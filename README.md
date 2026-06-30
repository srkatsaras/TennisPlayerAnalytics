# Tennis Match Analyser
![alt text](https://github.com/srkatsaras/TennisPlayerAnalytics/blob/main/image_readme.jpg)
## Installation
The project can be installed using one of the following ways:
1.  By creating a virtual enviroment and by installing the libraries supplied in the `requirements.txt` file.
__Preferred python version:__ Python 3.10.
```
$ python -m venv ./venv/
$ source venv/bin/activate
(venv)$ pip install -r requirements.txt
```
2.  By utilizing the supplied `Dockerfile` specification. This option is recommended despite not being as lightweight as using a virtual environment.
```
$ docker build --tag project .
$ docker run -d -p 5000:5000 project
```
## Overview
The project utilizes three neural network models:

1.  __A YOLOv8X model:__ pretrained, for identifying objects/people in each frame.
2.  __A ResNet50 model with a custom fully connected layer (2x14):__ for identifying 14 positions of the tennis court. Identifying these points allows for distance estimation.
3.  __A YOLOv5l model:__ trained on many tennis ball annotations, for identifying the tennis ball on the court.

### Features
1.  _Player and ball velocities and average velocities:_ using pixel--to--distance estimations, infer the distance covered by each player and the ball during each interval of sequential ball hits. The velocity can be easily found by also obtaining the duration (in frames) between sequential ball hits, and by utilizing the number of fps.

  Ball y positions:
   
  <img src="https://github.com/srkatsaras/TennisPlayerAnalytics/blob/main/ball_y_pos.jpg" data-canonical-src="https://github.com/srkatsaras/TennisPlayerAnalytics/blob/main/ball_y_pos.jpg" width="40%" />
   
2.  Minimap with player and ball positions (WIP).

### Challenges and solutions
1.  __Distinguishing among players and referees/audience:__ The pretrained YOLOv5 model cannot inherently tell apart people from players. Since there are 2 players in a tennis match, we only consider as players the individuals closer to the court points.
2.  __Ball misclassifications__: The manually trained YOLOv5l model can accurately capture the correct ball instance for most frames,  however it appears to also detect white spots on the court as a ball for a small number of frames. To aleviate this issue, we have tried to increase the confidence threshold from 0.2 to 0.28, leading to only correct instances of the ball to be identified for most frames. For the remaining frames, when a ball is not identified at all, we employ interpolation techniques on the location coordinates of the ball's bounding box.

## Future work
1.  __Real--time processing:__ The ball hit recognition (and subsequently the player and ball velocities) can be re--implemented for real time video streams. In this context, latent performance is also a crucial factor here: each frame must be processed quick enough to avoid delays. This can be done through the following adjustments:
   -  employ faster YOLO models, specifically for identifying the players. YOLOv8n can be a good alternative, given that identifying individuals on the frames is not prone to errors (in contrast to identifying ball positions, where a larger model might be necessary given the misclassifications in the YOLOv5l model.)
   -  perform processing every 10 frames instead of processing each frame.
