FROM cuda-ubuntu16.04-jetson-tx1-arm64:cuda8.0-cudnn6.0

# ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116

RUN apt-get update && \
    apt-get install -y ros-kinetic-ros-base \
                       ros-kinetic-desktop \
                       ros-kinetic-desktop-full
RUN apt-get install -y ros-kinetic-moveit \
                       ros-kinetic-octomap \
                       ros-kinetic-usb-cam \
                       ros-kinetic-openni2-launch \
                       ros-kinetic-ros-control \
                       ros-kinetic-ros-controllers
RUN apt-get install -y ros-kinetic-gazebo-ros-pkgs \
                       ros-kinetic-gazebo-ros-control \
                       ros-kinetic-kobuki-gazebo \
                       ros-kinetic-turtlebot-gazebo
RUN apt-get install -y ros-kinetic-rosbridge-server \
                       ros-kinetic-web-video-server \
                       ros-kinetic-tf2-web-republisher \
                       ros-kinetic-interactive-marker-proxy

RUN rosdep init && rosdep update && \
    apt-get install -y python-rosinstall && \
    apt-get clean && apt-get auto-remove
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116

# QtCreator ROS
RUN add-apt-repository -y ppa:levi-armstrong/qt-libraries-xenial && \
    add-apt-repository -y ppa:levi-armstrong/ppa && \
    apt update && apt install -y qt59creator && \
    apt install -y qt57creator-plugin-ros

WORKDIR /root/catkin_ws
CMD ["/bin/bash"]
