int size = 256;
int iconNumber = 5;
int maxDensity = 25;
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
  
  int density = 0;
  int n = 0;
  int x = 0;
  int y = 0;
  int x2;
  int y2;
  float D;
  float A;
  float l;
  float a = 0;
  boolean alreadyThere;
  PImage icon = new PImage();
  while((density/pow(size-1, 2))*100 < maxDensity) {
    println(n);
    icon = Icon[round(random(0, iconNumber-1))];
    a = radians(allowedAngle[round(random(0, allowedAngle.length-1))]);
    l = mag(icon.width/2, icon.height/2);
    x = floor(constrain(random(0, size-1), abs(l*cos(a)), ((size-1)-l*cos(a))));
    y = floor(constrain(random(0, size-1), abs(l*sin(a)), ((size-1)-l*sin(a))));
    
    alreadyThere = false;
    for (int i = 0; i <= max(icon.width, icon.height); i++) {
      for (int o = 0; o <= max(icon.width, icon.height); o++) {
        x2 = floor(cos(a)*(i-icon.width/2)+sin(a)*(o-icon.height/2)+icon.width/2);
        y2 = floor(cos(a)*(o-icon.height/2)+sin(a)*(i-icon.width/2)+icon.height/2);
        if (alpha(result.get(round(x+i-icon.width/2), round(y+o-icon.height/2))) > 125 && alpha(icon.get(x2, y2)) > 125) {
          alreadyThere = true;
          break;
        }
      }
    }
    if (!alreadyThere) {
    for (int i = -5; i <= max(icon.width, icon.height); i++) {
      for (int o = -5; o <= max(icon.width, icon.height); o++) {
        
        x2 = floor(cos(a)*(i-icon.width/2)+sin(a)*(o-icon.height/2)+icon.width/2);
        y2 = floor(cos(a)*(o-icon.height/2)+sin(a)*(i-icon.width/2)+icon.height/2);
        
        if (alpha(icon.get(x2, y2)) >= 255) {
         result.set(floor(x+i-icon.width/2), floor(y+o-icon.height/2), icon.get(x2, y2));
         density++;
        }
        n++;
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
