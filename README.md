# Sample Roku Channel
A sample scenegraph Roku app. Most of the code comes from https://developer.roku.com/docs/references/scenegraph/control-nodes/componentlibrary.md. What I added was a couple custome components and a few random animations for fun. I didn't touch the actualy spinner component that is being downloaded, only the code in this repo.


### To Side Load

To side load, you must enter in the username of the device, the password of the device, and the ip address in the following format:

```
$ ./make.sh help
$ ./make.sh --user [username] --pw [password] --ip [Device IP]
```
