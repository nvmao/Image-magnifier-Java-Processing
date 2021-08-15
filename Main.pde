
import java.util.Random;



final int width = 860;
final int height = 640;


PImage img; 

int scale = 1;

void setup() {
  size(860, 640);
  
 
  img = loadImage("image.jpg"); 
  img.resize(860,640);
}

void draw() {
  background(0);
  
  image(img, 0, 0, img.width, img.height);
  

  
  float dis = 20;
  int image_w_s = img.width/4;
  int image_h_s = img.height/4;
  
  PImage displayImage = createImage(image_w_s, image_h_s, RGB); 
  
  for(int i = 0 ; i < image_w_s;i++){
    for(int j = 0 ; j < image_h_s;j++){
        displayImage.set(i,j,img.get(i+mouseX - image_w_s/2, j+mouseY - image_h_s/2));
    }
  }
  
  PImage zoomImage = zoomTheImage(displayImage,scale);
  
  float pos_x = mouseX + dis;
  float pos_y = mouseY + dis;
  
  if(pos_x + image_w_s > width){
    pos_x = mouseX - dis - image_w_s;
  }
  if(pos_y + image_h_s > height){
    pos_y = mouseY - dis - image_h_s;
  }

  // resize
  zoomImage.resize(image_w_s,image_h_s);
  
  
  // draw rect
  fill(0);
  rect(pos_x-2, pos_y-2,image_w_s+2,image_h_s+2);
  image(zoomImage,pos_x, pos_y,image_w_s,image_h_s);
  
}

PImage zoomTheImage(PImage img,int times){
  PImage zoomImage = null; 
  for(int i = 0; i < times;i++){
     int w = img.width/2;
     int h = img.height/2;
     zoomImage = createImage(w,h, RGB); 
    
 
    for(int row = 0 ; row < w;row++){
      for(int col = 0 ; col < h;col++){
          zoomImage.set(row,col,img.get(row + img.width/2 - w/2, col + img.height/2 - h/2 ));
      }
    }
    
    img = zoomImage;
    
  }
   return zoomImage;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scale -= e;
  
  if(scale < 1){
    scale = 1;
  }
  else if(scale > 6){
    scale = 6;
  }
  
}
