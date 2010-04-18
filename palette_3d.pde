

float xmag, ymag = 0;
float newXmag, newYmag = 0; 
ColorPoint[] color_points;
ArrayList colorp;
int num_colors;
boolean drawbox = true;

String[] lines;
String palette = "named";
String colorspace = "rgb";
Mode color_space;
float sphere_size = 4.0;

int palette_index = 0;

//String[] palettes = {"etsy", "flickr","rainbow","pastel", "basic", "cnn", "cnet","oracle", "facebook", "ebay", "amazon", "microsoft", "twitter", "gmail","metafilter", "redhat_www", "achilles", "Named_Colors", "Ega","Web", "print", "CoralReef","touch_markers","HuesAndSaturations", "volcano", "Human_eyes","bee_queen", "wood_heart", "roses"};

String[] palettes = {"Named_Colors", "Web", "Ega", "print","HuesAndSaturations", "13bow", "23", "3d", "4zebbow", "8rain2",
                    "achilles", "altern", "basic", "blakwht", "cat", "christma", "chroma", "cycler", "default", "egan1", "fadechr1",
                    "firecode", "firestrm", "froth3", "froth6", "hls1", "hls16", "hunk", "mandmap", "mixed", "new", "pastel", "rainbow", "rgb2",
                    "ribbon15", "ribbon17", "room", "smooth", "smstrp4", "special2", "spect3", "vertigo", "whiteblk"};

void read_palette(String palette_name) {  
  String filename = palette_name + ".gpl";
  lines = loadStrings(filename);

   color_points = new ColorPoint[lines.length];

  int index = 0;
  // read each tab seperated line and create a "ColorPoint" for it
  // why are we starting at 3? the first three lines of a gimp palette file are text headers 
  for (int x = 3; x < lines.length; x++) {
    String line = lines[x];
    // this is a comment to tell you that # is a comment
    if (line.charAt(0) == '#') {
        continue;
      } 
    String[] pieces = splitTokens(trim(line), " \t");
    color_points[index] = new ColorPoint(int(trim(pieces[0])), int(trim(pieces[1])), int(trim(pieces[2])));
    index++;
  }
  num_colors = index;

}

void setup() {
  size(700,700, P3D);
  noStroke();
  colorMode(RGB);
  frameRate(10);
  color_space = new Mode("Red", "Green", "Blue");
  read_palette(palettes[palette_index]);
}

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

class ColorPoint {
  int r;
  int g;
  int b;

  ColorPoint(int cr, int cg, int cb) {
    r = cr;
    g = cg;
    b = cb;
  }

  void draw() {
    pushMatrix();
    color c = color(r,g,b);
    if (color_space.x == "Hue") {
      translate(hue(c), saturation(c), brightness(c)); 
    }
    if (color_space.x == "Red") {
      translate(r,g,b);
    }
    fill(r,g,b);
    sphere(sphere_size);
    popMatrix();
  }
}

void changeColorSpace() {
  if (color_space.x == "Hue") {
    color_space = new Mode("Red", "Green", "Blue");
  } 
  else  {
    color_space = new Mode("Hue", "Saturation", "Brightness");
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      sphere_size = sphere_size + 0.25;
    }
    if (keyCode == DOWN) {
      sphere_size = sphere_size - 0.25;
    }
    
    if (sphere_size <= 0.25) {
      sphere_size = 0.25;
    }
    
    if ((keyCode == RIGHT) || (keyCode == LEFT)) {
        if (keyCode == RIGHT) { palette_index++; }
        if (keyCode == LEFT)  { palette_index--; }
        if ((palette_index >= palettes.length) || (palette_index <= 0)) {
            palette_index = 0;
        }
        palette = palettes[palette_index];
        read_palette(palette);
    }

  }
  if (key == 'b') {
      if (drawbox) { 
        drawbox = false;
      } else {
        drawbox = true;
      } 
  }

  if (key == ' ') {
    changeColorSpace();
  } 
}




void draw() {
  lights();
  //ambientLight(128,128,128);
  background(0);

  //ambient(200);
  //specular(128);
  shininess(100.0);
  pushMatrix();

  translate(width/2, height/2,-50);

  //rotate the cube with the mouse
  if (mousePressed == true) {
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

  }
  rotateX(-ymag); 
  rotateY(-xmag); 
  
  strokeWeight(2);
  
  // the axis
  strokeJoin(MITER);
  stroke(240,240,240, 150);
  line(0,0,0, 256,0,0);
  line(0,0,0, 0,256,0);
  line(0,0,0, 0,0,256);

  if (drawbox) {
  // a box
    strokeWeight(1);
    stroke(240,240,240,100);
 
    line(256,256,0,0,256,0);
    line(256,256,0,256,0,0);
    line(256,256,256,0,256,256);
    line(256,256,256,256,0,256);
    line(256,256,256, 256,256,0);
    line(0,256,256,0, 256,0);
    line(0,0,256,0, 256,256);
    line(256,256,0, 256,256,256);
    line(256,0,0, 256,0,256); 
    line(256,0,256, 0,0,256);
  }

  //load up our fonts
  PFont sans;
  PFont sansScreen;
  sans = loadFont("SansSerif-48.vlw");
  sansScreen = loadFont("SansSerif-20.vlw");

  // drark grey for the labels
  fill(240,240,240,200);  

  // draw the label for what palette we are currently using
  textMode(SCREEN);
  textFont(sansScreen,20);
  text(palettes[palette_index], 15,height-15);

  // switch text mode back to model to label the axis's
  textMode(MODEL);
  textFont(sans, 20); 

  // The color space labels for the x/y/x axis (aka, r,g,b, etc)
  text(color_space.x, 275,0,0);
  text(color_space.y, 0,275,0);
  text(color_space.z, 0,0, 275);
  
  noStroke();
  pushMatrix();
  for (int count = 0; count < num_colors; count++) {
    color_points[count].draw();
  }

  translate(0,0,0);
  popMatrix();
  popMatrix();
}


