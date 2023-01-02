# MarchingCubes_Processing

### Simple marching cubes algorithm written in Processing

Edge interpolation added for smoother results.
If you don't want interpolated result overwrite intFactor on line 98 to 0.5 -> center of the edge

Note that the sample values are hardcoded in interpolatePoint() function and are the same for each edge!<br>
That's the reason why interpolation appears to be inverse on one side.<br>
To see proper results provide your own field of values.