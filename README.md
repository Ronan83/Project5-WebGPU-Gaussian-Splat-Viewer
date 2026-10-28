# Project5-WebGPU-Gaussian-Splat-Viewer

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* (TODO) YOUR NAME HERE
* Tested on: (TODO) **Google Chrome 222.2** on
  Windows 22, i7-2222 @ 2.22GHz 22GB, GTX 222 222MB (Moore 2222 Lab)

### Live Demo

[![](img/thumb.png)](http://TODO.github.io/Project4-WebGPU-Forward-Plus-and-Clustered-Deferred)

### Demo Video/GIF

[![](img/video.mp4)](TODO)

### (TODO: Your README)

*DO NOT* leave the README to the last minute! It is a crucial part of the
project, and we will not be able to grade you without a good README.

This assignment has a considerable amount of performance analysis compared
to implementation work. Complete the implementation early to leave time!

### Performance Analysis

#### 2. Preprocessing workgroup size

The original local Viewer was tested with 1,063,091 Gaussians from
`bicycle_30000.cleaned.ply`, camera preset 0, Gaussian scaling 1.00, and a
1283 × 741 canvas. Each configuration was warmed up for approximately five
seconds, followed by 21 samples of the displayed instantaneous FPS.

| Workgroup size | Median displayed FPS | Observed range |
| --- | ---: | ---: |
| 64 | 153.85 | 128.21–185.19 |
| 128 | 149.25 | 128.21–163.93 |
| 256 | 147.06 | 125.00–172.41 |

The 64-thread configuration had a median approximately 4.6% above 256 in this
comparison, but the observed ranges overlap substantially. These short runs
do not establish a reliable winner. Workgroup size can affect scheduling and
resource allocation, while sorting and rasterization also contribute to total
frame time. The measurements are samples of the existing FPS display rather
than isolated GPU preprocessing timings or averages over every rendered frame.

The sorting capacity was held at 3840 keys per dispatch. Frustum culling was
enabled in all three workgroup-size measurements. The current temporary
culling comparison changes are a separate experiment.

See the [full explanation, raw readings, and screenshots](analysis/workgroup-size/README.md).

### Credits

- [Vite](https://vitejs.dev/)
- [tweakpane](https://tweakpane.github.io/docs//v3/monitor-bindings/)
- [stats.js](https://github.com/mrdoob/stats.js)
- [wgpu-matrix](https://github.com/greggman/wgpu-matrix)
- Special Thanks to: Shrek Shao (Google WebGPU team) & [Differential Guassian Renderer](https://github.com/graphdeco-inria/diff-gaussian-rasterization)
