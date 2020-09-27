//x = 16*pow(sin(t), 3);
//y = 13*cos(t) - 5*cos(2*t) - cos(4*t);
//x = [-16, 16]
//y = [12, -17] = +2.5
//min x & y = 7

int size = 256;
int iconNumber = 5;
int MaxDensity;
float[] allowedAngle = {0, 90, 180, 270};
PImage result;

PImage[] Icon;

void setup() {
  surface.setResizable(true);
  surface.setSize(size, size);
  
  Icon = new PImage[iconNumber];
  for (int i = 0; i < iconNumber; i++) {
    Icon[i] = loadImage("img"+str(i+1)+".png");
  }
  
  result = createImage(size, size, ARGB);
  
  //int density;
  int x = 0;
  int y = 0;
  int x2;
  int y2;
  float D;
  float A;
  float l;
  float a = 0;
  boolean alreadyThere;
  PImage icon;
  for (int n = 0; n < 100;  n++) {
    icon = Icon[round(random(0, iconNumber-1))];
    a = radians(allowedAngle[round(random(0, allowedAngle.length-1))]);
    l = mag(icon.width/2, icon.height/2);
    x = round(constrain(random(0, size-1), abs(l*cos(a)), ((size-1)-l*cos(a))));
    y = round(constrain(random(0, size-1), abs(l*sin(a)), ((size-1)-l*sin(a))));
    
    alreadyThere = false;
    for (int i = 0; i <= max(icon.width, icon.height); i++) {
      for (int o = 0; o <= max(icon.width, icon.height); o++) {
        x2 = round(cos(a)*(i-icon.width/2)+sin(a)*(o-icon.height/2)+icon.width/2);
        y2 = round(cos(a)*(o-icon.height/2)+sin(a)*(i-icon.width/2)+icon.height/2);
        if (alpha(result.get(round(x+i-icon.width/2), round(y+o-icon.height/2))) > 125 && icon.get(x2, y2) > 125) {
          alreadyThere = true;
          n--;
          print("There");
          break;
        }
      }
    }
    if (!alreadyThere) {
    for (int i = 0; i <= max(icon.width, icon.height); i++) {
      for (int o = 0; o <= max(icon.width, icon.height); o++) {
        
        //A = atan2(o-icon.height/2, i-icon.width/2);
        //D = dist(icon.width/2, icon.height/2, i, o);
        x2 = floor(cos(a)*(i-icon.width/2)+sin(a)*(o-icon.height/2)+icon.width/2);
        y2 = floor(cos(a)*(o-icon.height/2)+sin(a)*(i-icon.width/2)+icon.height/2);
        
        //result.set(floor(x+i-icon.width/2), floor(y+o-icon.height/2), icon.get(int(cos(a)*dist(icon.width/2, icon.height/2, i, o)), int(sin(a)*dist(icon.width/2, icon.height/2, i, o))));
        
        //result.set(floor(x+i-icon.width/2), floor(y+o-icon.height/2), icon.get(i, o));
        if (alpha(icon.get(x2, y2)) >= 255) {
         result.set(floor(x+i-icon.width/2), floor(y+o-icon.height/2), icon.get(x2, y2));
        }
      }
    }
    }
  }
  
  result.save("result.png");
}

void draw() {
  background(0);
  image(result, 0, 0);
}

//PImage writeHeartImage(PImage img, int x, int y, int A, int scale) {
//  PImage result = img;
  
//  for (int a = A; a < A+360; a++) {
    
//  }
  
//}
