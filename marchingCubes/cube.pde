class Cube {
  float x, y, z;
  PVector[] points = new PVector[8];
  PVector[] midpoints = new PVector[12];
  PVector[] newMidpoints = new PVector[12];

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
    
    midpoints[0] = findMidpoint(points[0],points[1]);
    midpoints[1] = findMidpoint(points[1],points[2]);
    midpoints[2] = findMidpoint(points[2],points[3]);
    midpoints[3] = findMidpoint(points[0],points[3]);
    midpoints[4] = findMidpoint(points[4],points[5]);
    midpoints[5] = findMidpoint(points[5],points[6]);
    midpoints[6] = findMidpoint(points[6],points[7]);
    midpoints[7] = findMidpoint(points[7],points[4]);
    midpoints[8] = findMidpoint(points[0],points[4]);
    midpoints[9] = findMidpoint(points[1],points[5]);
    midpoints[10] = findMidpoint(points[2],points[6]);
    midpoints[11] = findMidpoint(points[3],points[7]);
    

  }



  int findConfig() {
    String config = "";
    String val;
    
    for (int i = 0; i < 8; i++) {
      PVector p = points[i];
      

      /* KOSTKA
      if (p.x >= boundarySize/2-2 && p.x <= boundarySize/2+2 && p.y >= boundarySize/2-2 && p.y <= boundarySize/2+2 && p.z >= boundarySize/2-2 && p.z <= boundarySize/2+2) {
        val = "1";
      } */
      
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
  
  PVector findMidpoint(PVector a, PVector b) {
    return new PVector((a.x+b.x)/2,(a.y+b.y)/2,(a.z+b.z)/2);
  }
  
  void triangulate() {
    int config = findConfig();
    int vert = 0;
    fill(128);
    stroke(255);
    strokeWeight(1);
    
    beginShape(TRIANGLES);
    
    while (vert < 16 && triTable[config][vert] != -1) {
      PVector v = midpoints[triTable[config][vert]];
      vertex(v.x*multiplier,v.y*multiplier,v.z*multiplier);
      vert++;
    }
    
    endShape();
  
  }
}
