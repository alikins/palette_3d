

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
//String[] palettes = {
//  "named", "blues", "greens", "cranes", "web", "print"};
String[] palettes = {"etsy", "flickr","rainbow","pastel", "basic", "cnn", "cnet","oracle", "facebook", "ebay", "amazon", "microsoft", "twitter", "gmail","metafilter", "redhat_www", "achilles", "Named_Colors", "Ega","Web", "print", "CoralReef","touch_markers","HuesAndSaturations", "volcano", "Human_eyes","bee_queen", "wood_heart", "roses"};
//String[] palettes = {"Web"};
//String[] palettes = {"13bow","2","23","3","3d","4","4zebbow","4zebbowx","560sel","8rain","8rain2","8temp","8zebbow2","aaron","aas","achilles","alo","altern","anenome","anet","angels","autumn","autumn2","axe","b1","b2","b3","b4","b5","b6","b7","b8","bandbow1","bandw","basic","bbr001","bears","bgb","bgold","biglake","black","blakwhit","blakwht","blend","blend1","blend2","blend3","blend4","blend8","blendfff","blengbyg","bluein","blueorng","blueout","blues","bluorng","bonzo","border","borders","bp","bpg","brass","brite","brwg","busyl","bwb","byb","candy","candy1","cap","cap1","caramel","cascade","cat","chief","chiffon","china","christma","chroma","chroma2","chroma3","chroma4","clouds","coldfire","colors","cool","copper","cpt","cranes","crwn","cycler","darkie","dblfn","default","defaultw","dragon","dw","egan1","egan2","egan3","egan4","egasoft","emerald","erd","escher","exp3","fadechr1","fadern1","fadern2","fadern3","fadern4","fadern5","feather","fire2","firecod2","firecode","firestrm","fish","flamey","flori","flowers","flowers1","flowers3","fourain","fourain2","frcoast","frosty1","frosty2","froth3","froth316","froth6","froth616","fun1","g1","g2","g3","g4","g5","g6","g7","g8","gamma1","gamma2","garden","glass","glasses1","glasses2","glasses5","gletsch","gold","goodega","grayblue","grayish","gred","green","greenin","greenout","greens","grey","grid","grntrel","hawaii","haystack","headache","hearts","hilite","hls1","hls10","hls12","hls15","hls16","hls17","hls19","hls2","hls20","hls3","hls4","hls5","hls6","hls7","hls8","hls9","hlsrain1","hlsrain2","hlsrain3","hlsrain4","hlsrain5","hlsrainb","horns","hotice","hunk","hybrid","ice","iiieeh","indigo","janine","japan","jellyfsh","jewel","jewels1","jewels2","jewels3","jewels4","jfan","jstripe","juteblue","jutemap","jutemap2","jutes","kahki","koldlaf","lace","landscap","laser","leon","lichen","light","limeblk","lite","litnin1","longs","lyapblue","lyapunov","mandel","mandel2","mandmap","masts","med","melo","metal","mist","mixed","monk","monk1","monk2'","mushrm","myega","necklace","neon","new","new1","new2","new3","newmap","nice","nkohala","nobow","noel","oil","okay","olympus","op2","osb","owl","paintjet","pale","panda","pastel","patriot","pc","peach","phong1","phong2","pinkblue","plasma1","plasma2","polar","poppy","porche01","povray","prplgrn","pumpkin","pvland","r1","r2","r3","r4","r5","r6","r7","r8","rain4","rain4g1","rain4x","rain4x2","rain4x3","rainb","rainbow","rainbow2","rainbow3","rainbow4","rainbow5","rainbow6","rainbow7","rainhyb","rbow","rby","redand","redfred","redgrn","redin","redout","reds","reds2","redsun","reg","revblue","revlyp","rgb","rgb2","ribbon","ribbon1","ribbon10","ribbon12","ribbon13","ribbon15","ribbon16","ribbon17","ribbon18","ribbon2","ribbon20","ribbon21","ribbon22","ribbon3","ribbon4","ribbon5","ribbon6","ribbon7","ribbon8","ribbon9","room","rose1","rosewhit","royal","royal1","roygbv","roygold","rset2","rw","ryb1","ryl-rb","sanfran","sea","sea2","seattle","smooth","smstrp3","smstrp4","smstrp5","snowtree","sparse","special2","spect1","spect2","spect3","spect4","spect5","spect6","spect7","spiral","spirit","star","stargate","steptoe","storm","stripe","stripe2","stripe3","sweet","tealsand","temp","topo","topo2","trace4","tropic","turqoise","twist","tworain","tworain2","tworain3","twowhite","unknown","valintin","vertigo","vette63","volcano","volcano2","volcano3","volcano4","volcano5","volcano6","volcano7","vooon","white","whiteblk","wild","windsrf2","windsurf","wine","wood","world","worms","wybr","x-temple","yelpurp1","ygb","yools","zebbow2","zebra","zoot"};
// 13bow, 23, 3d, 4zebbowx, 8rain2, achilles, altern, basic, blakwht, cat, christma, chroma, cycler, default, egan1, fadechr1, fadern1, firecode, firestrm
// froth3, froth6, hlsl1, hls16, hunk, mandmap, mixed, new, pastel, rainbow, rgb2, ribbon15, ribbon17, room, smooth, smstrp4, special2, spect3, vertigo, whiteblk
void read_palette(String palette_name) {  
//  String filename = palette_name + ".txt";
  String filename = palette_name + ".gpl";
  lines = loadStrings(filename);

   color_points = new ColorPoint[lines.length];
  //colorp = new ArrayList();

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
  //    println( index + " " + pieces.length + " " +  pieces[0] + " " + color_points[index].r + " " + pieces[1] + " " + color_points[index].g + " " + color_points[index].b);
    index++;
  }
  num_colors = index;

}

void setup() {
  size(800,800, P3D);
  noStroke();
  colorMode(RGB);
  frameRate(10);
  color_space = new Mode("Red", "Green", "Blue");

  read_palette(palettes[palette_index]);

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


class ColorPoint {
  int r;
  int g;
  int b;

  ColorPoint(int cr, int cg, int cb) {
    //println(cr + " " + cg + " " + cb);
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
    //println(hue(c) + "  " + saturation(c) + "  " + brightness(c));
    //translate(hue(c), saturation(c), brightness(c));
    fill(r,g,b);
    //println(r + " " + g + " " + b);
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

  // 
  //stroke(255,255,255);
  translate(width/2, height/2,-100);

  //roate the cube with the mouse
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

  //  strokeWeight(20);
  
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
     //fill(240,240,240,100); 
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
  //  sansScreen = loadFont("SansSerif-20.vlw");

  // drark grey for the labels
  fill(240,240,240,200);  

  // draw the label for what palette we are currently using
  textMode(SCREEN);
  textFont(sansScreen,20);
  text("palette: " + palettes[palette_index], 15,height-15);

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


