import controlP5.*;
import peasy.*;

PeasyCam cam;
ControlP5 controlP5;

int boundarySize = 11;
int cols = boundarySize;
int rows = boundarySize;
int zAxis = boundarySize;

Cube[][][] cubes;

int multiplier = 10;
int marching = 0;

float isoVal = 0.2;

void initCam() {
  cam = new PeasyCam(this, 75);
  cam.setMinimumDistance(75);
  cam.setMaximumDistance(150);
}

void initControl() {
  controlP5 = new ControlP5(this);
  controlP5.setAutoDraw(false);
  Button cubeButton = controlP5.addButton("mesh").setPosition(25, 25).setSize(150, 25).setValue(0).activateBy(ControlP5.RELEASE);

  cubeButton.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      switch(event.getAction()) {

        case(ControlP5.ACTION_RELEASED):

          cubes = null;
          cubes = new Cube[(int)(cols -1)][(int)(rows -1)][(int)(zAxis -1)];
  
          for (int x = 1; x< cubes.length -1; x++) {
            for (int y = 1; y< cubes[x].length -1; y++) {
              for (int z = 1; z< cubes[x][y].length -1; z++) {
  
                cubes[x][y][z] = new Cube(x, y, z);
               
              }
            }
          }
          
          marching = 1;
      }
    }
  }
  );
}


void setup() {
  size(1024, 768, P3D);
  noiseDetail(150);
  initCam();
  initControl();
}


void gui() {
  controlP5.draw();
  controlP5.setAutoDraw(false);
}

void draw() {
  background(64);
  stroke(0);
  strokeWeight(5);
  translate(-cols*multiplier/2, -rows*multiplier/2, -zAxis*multiplier/2);

  for (int x = 1; x < cols-1; x++) {
    for (int y = 1; y < rows-1; y++) {
      for (int z = 1; z < zAxis-1; z++) {
        /*
        if (x >= boundarySize/2-2 && x <= boundarySize/2+2 && y >= boundarySize/2-2 && y <= boundarySize/2+2 && z >= boundarySize/2-2 && z <= boundarySize/2+2) {
                    stroke(255);
        }  */
        
        if( (x-(boundarySize/2))*(x-(boundarySize/2)) + (y-(boundarySize/2))*(y-(boundarySize/2)) + (z-(boundarySize/2))*(z-(boundarySize/2)) < 7) {
          stroke(255);
        }
        else {
          stroke(0);
        }
        
        
        point(x*multiplier, y*multiplier, z*multiplier);
      }
    }
  }


  if (marching == 1) {
    for (int x = 1; x<cubes.length-1; x++) {
      for (int y = 1; y<cubes[x].length-1; y++) {
        for (int z = 1; z<cubes[x][y].length-1; z++) {
          cubes[x][y][z].triangulate();
        }
      }
    }
  }


  cam.beginHUD();
  gui();
  cam.endHUD();
}
