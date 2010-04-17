

float xmag, ymag = 0;
float newXmag, newYmag = 0; 
Thing[] things;
String[] lines;
//String palette = "web";
String colorspace = "rgb";
Mode color_space;

void setup() {
  size(400,400, P3D);
  noStroke();
  colorMode(RGB);
  frameRate(10);
  
  if (colorspace == "rgb") {
    color_space = new Mode("Red", "Green", "Blue");
  }
  if (colorspace == "hsb") {
   color_space = new Mode("Hue", "Saturation", "Brightness");
  }

  String filename = param("palette") + ".txt";
  //String filename = palette + ".txt";
  //println(filename);
  lines = loadStrings(filename);
  //lines = loadStrings("blues.txt");
  //lines = loadStrings("greens.txt");
  //lines = loadStrings("cranes.txt");
  //lines = loadStrings("named_colors.txt");
  //lines = loadStrings("web.txt");
  //lines = loadStrings("pantone_process.txt");

  // int skip = 32;
  //int r_count = 256/skip;

  //things = new Thing[r_count*r_count*r_count];

  int index = 0;
  //println(lines.length);
  //println(things.length);
  things = new Thing[lines.length];

  for (int x = 0; x < lines.length; x++) {
    String[] pieces = split(lines[x], '\t');
    things[x] = new Thing(int(pieces[0]), int(pieces[1]), int(pieces[2]));
  }
  //  for (int x = 0; x < r_count; x++){
  //    for (int y = 0; y < r_count; y++) {
  //      for (int z = 0; z < r_count; z++) {
  //        println(index);
  //        things[index] = new Thing(x*skip, y*skip, z*skip);
  //        index++;    
  //      }
  //    }
  //  }
}
//lights();

class Mode {
   String x;
  String y;
  String z;
 
  Mode(String cx, String cy, String cz) {
    x = cx;
    y = cy;
    z = cz;
  }
}


class Thing {
  int r;
  int g;
  int b;

  Thing(int cr, int cg, int cb) {
    //println(cr + " " + cg + " " + cb);
    r = cr;
    g = cg;
    b = cb;
  }

  void draw() {
    pushMatrix();
    translate(r,g,b);
    color c = color(r,g,b);
    //println(hue(c) + "  " + saturation(c) + "  " + brightness(c));
    //translate(hue(c), saturation(c), brightness(c));
    fill(r,g,b);
    //println(r + " " + g + " " + b);
    sphere(4);
    popMatrix();
  }
}

void draw() {
//  lights();
  background(0);

  pushMatrix();

  // 
  //stroke(255,255,255);
  translate(width/2, height/2, -30);

  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;

  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0; 
  }

  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0; 
  }

  rotateX(-ymag); 
  rotateY(-xmag); 
  strokeWeight(2);

  //  strokeWeight(20);
  strokeJoin(MITER);
  stroke(240,240,240, 150);
  line(0,0,0, 256,0,0);
  line(0,0,0, 0,256,0);
  line(0,0,0, 0,0,256);

  PFont metaBold;
  metaBold = loadFont("SansSerif-48.vlw");
  fill(240,240,240,200);
  textFont(metaBold, 20); 
  //textMode(SCREEN);
  text(color_space.x, 275,0,0);
  text(color_space.y, 0,275,0);
  text(color_space.z, 0,0, 275);
  noStroke();

  pushMatrix();
  //int items = things.length;
  for (int count = 0; count < things.length; count++) {
    things[count].draw();
  }

  translate(0,0,0);

  popMatrix();

  popMatrix();
}

