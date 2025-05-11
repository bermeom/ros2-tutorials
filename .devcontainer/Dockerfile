ARG DOCKER_REPO
ARG ROS_DISTRO
ARG IMAGE_SUFFIX
FROM $DOCKER_REPO:$ROS_DISTRO$IMAGE_SUFFIX
# Dev container arguments
ARG USERNAME=devuser
ARG U_ID=1000
ARG G_ID=${U_ID}


# Install basic apt packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git libcanberra-gtk-module libcanberra-gtk3-module fuse3 libfuse2 libqt5svg5-dev \
    python3-pip python3-opencv python3-tk python3-pyqt5.qtwebengine

# Install additional Python modules
RUN pip3 install --break-system-packages matplotlib transforms3d

# Use Cyclone DDS as middleware
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp

# Install extra tools for development
RUN apt-get update && apt-get install -y --no-install-recommends \
    gdb gdbserver nano

# In Ubuntu 24.04, there is already a user named "ubuntu" with UID 1000.
# Delete this in the (common) event that the user on the host also has this UID.
RUN touch /var/mail/ubuntu \
    && chown ubuntu /var/mail/ubuntu \
    && userdel -r ubuntu

# # Create new user and home directory
RUN groupadd --gid $U_ID $USERNAME \
    && useradd --uid ${G_ID} --gid ${U_ID} --create-home ${USERNAME} \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && mkdir -p /home/${USERNAME} \
    && chown -R ${U_ID}:${G_ID} /home/${USERNAME} \
    && chsh -s /bin/bash ${USERNAME}

# Move Groot2 to new user's home directory and ensure it can be run
# RUN groupadd fuse \
#     && usermod -aG fuse ${USERNAME}
# RUN curl -o Groot2.AppImage https://s3.us-west-1.amazonaws.com/download.behaviortree.dev/groot2_linux_installer/Groot2-v1.6.1-x86_64.AppImage \
#  && chown ${U_ID}:${G_ID} Groot2.AppImage

# Install additonal packages - add any that you need
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y python3-pip python-is-python3 ssh neovim git
# ENV SHELL /bin/bash

# Source ROS environment automatically
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /home/$USERNAME/.bashrc
# RUN echo "source /home/ws/install/setup.bash" >> /home/$USERNAME/.bashrc

# Set the default user
USER $USERNAME
# CMD ["/bin/bash"]

# ENTRYPOINT ["bash"]