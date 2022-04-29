import os
import shlex
import subprocess


def find_ros_python_packages():
    ros_ws = os.environ['ROS_WORKSPACE']
    cmd = shlex.split(
        f'bash -c "source {ros_ws}/install/setup.bash && echo $PYTHONPATH"')
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, universal_newlines=True)
    for line in p.stdout:
        paths = line.rstrip().split(':')
    p.communicate()
    return paths

def Settings(**kwargs):
    return {'sys_path': find_ros_python_packages()}
