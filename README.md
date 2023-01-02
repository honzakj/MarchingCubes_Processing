# MarchingCubes_Processing

### Simple marching cubes algorithm written in Processing

Edge interpolation added for smoother results.<br><br>
If you don't want interpolated results change line 98 in cube.pde:

```
    intPoint = PVector.lerp(a, b, abs(intFactor)); -> intPoint = PVector.lerp(a, b, 0.5);
```


Note that the sample values are hardcoded in interpolatePoint() function and are the same for each edge!<br>
That's the reason why interpolation appears to be inverse on one side.<br><br>
To see proper results provide your own field of values.