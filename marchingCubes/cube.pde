class Cube {
  float x, y, z;
  PVector[] points = new PVector[8];
  PVector[] intPoint = new PVector[12];
  PVector[] newintPoint = new PVector[12];

  Cube(float _x, float _y, float _z) {
    // First point is bottom left
    x = _x;
    y = _y;
    z = _z;
    
    
   /*- Vertex indices
                        4  ___________________  5
                          /|                 /|
                         / |                / |
                        /  |               /  |
                   7   /___|______________/6  |
                      |    |              |   |
                      |    |              |   |
                      |  0 |______________|___| 1
                      |   /               |   /
                      |  /                |  /
                      | /                 | /
                      |/__________________|/
                     3                     2
    */
    

    points[0] = new PVector(x, y, z);
    points[1] = new PVector(x+1, y, z);
    points[2] = new PVector(x+1, y+1, z);
    points[3] = new PVector(x, y+1, z);
    points[4] = new PVector(x, y, z+1);
    points[5] = new PVector(x+1, y, z+1);
    points[6] = new PVector(x+1, y+1, z+1);
    points[7] = new PVector(x, y+1, z+1);
    
    intPoint[0] = interpolatePoint(points[0],points[1]);
    intPoint[1] = interpolatePoint(points[1],points[2]);
    intPoint[2] = interpolatePoint(points[3],points[2]);
    intPoint[3] = interpolatePoint(points[0],points[3]);
    intPoint[4] = interpolatePoint(points[4],points[5]);
    intPoint[5] = interpolatePoint(points[5],points[6]);
    intPoint[6] = interpolatePoint(points[7],points[6]);
    intPoint[7] = interpolatePoint(points[4],points[7]);
    intPoint[8] = interpolatePoint(points[0],points[4]);
    intPoint[9] = interpolatePoint(points[1],points[5]);
    intPoint[10] = interpolatePoint(points[2],points[6]);
    intPoint[11] = interpolatePoint(points[3],points[7]);
    

  }



  int findConfig() {
    String config = "";
    String val;
    
    for (int i = 0; i < 8; i++) {
      PVector p = points[i];
      

      /* CUBE
      if (p.x >= boundarySize/2-2 && p.x <= boundarySize/2+2 && p.y >= boundarySize/2-2 && p.y <= boundarySize/2+2 && p.z >= boundarySize/2-2 && p.z <= boundarySize/2+2) {
        val = "1";
      } */
      
      // SPHERE
      if( (p.x-(boundarySize/2))*(p.x-(boundarySize/2)) + (p.y-(boundarySize/2))*(p.y-(boundarySize/2)) + (p.z-(boundarySize/2))*(p.z-(boundarySize/2)) < 7) {
           val = "1";
      }     
      else {
        val = "0";
      }
      
      
      config = val + config;
    }
    return unbinary(config);
  }
  
  PVector interpolatePoint(PVector a, PVector b) {
    float aVal = 1;
    float bVal = 0;
    float intFactor;
    PVector intPoint;
    
    if (aVal - bVal != 0) {
      intFactor = (aVal - isoVal) / (aVal - bVal);
    } else {
      intFactor = 0.5;
    }
    
    intFactor = constraint(intFactor, 0, 1);
    intPoint = PVector.lerp(a, b, abs(intFactor));
    
    return intPoint;
  }
  
  void triangulate() {
    int config = findConfig();
    int vert = 0;
    fill(128);
    stroke(255);
    strokeWeight(1);
    
    beginShape(TRIANGLES);
    
    while (vert < 16 && triTable[config][vert] != -1) {
      PVector v = intPoint[triTable[config][vert]];
      vertex(v.x*multiplier,v.y*multiplier,v.z*multiplier);
      vert++;
    }
    
    endShape();
  
  }
}
