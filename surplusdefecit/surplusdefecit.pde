import org.gicentre.utils.spatial.*;



float rotate_val = 0;
int zoom = 0;
int gpsScale = 10000;
int w;
int h;

//SimpleSpreadsheetManager sm;

SimpleSpreadsheetManager sm = new SimpleSpreadsheetManager();

WebMercator proj = new WebMercator();

void setup() {
  size(1280, 790, P3D);
  frameRate(30);

  sm.init("myProjectName", GoogleLogin, GooglePassword);
  sm.fetchSheetByKey(GoogleDocKey, 0);
  //println(sm.getCellValue("Lat",2));
}

void draw() {
  //rotate_val = rotate_val + 0.1;
  translate(width/2, height/2, zoom);
  background(0);
  rotateY(rotate_val);
  stroke(255);
  strokeWeight(10);
  //scale(50);



  //beginShape();
  for (int i=0; i < sm.currentTotalRows -1; i++) {

    //vertex(float(sm.getCellValue("Lat",i)),float(sm.getCellValue("Long",i)),float(sm.getCellValue("Alt",i)));
    //vertex(float(sm.getCellValue("Lat",i)),float(sm.getCellValue("Long",i)));


    
    //text(sm.getCellValue("Capital", i),float(sm.getCellValue("Lat", i))*gpsScale, float(sm.getCellValue("Long", i))*gpsScale, float(sm.getCellValue("Alt", i)));
    //line(float(sm.getCellValue("Lat", i))*gpsScale, float(sm.getCellValue("Long", i))*gpsScale, float(sm.getCellValue("Alt", i)), float(sm.getCellValue("Lat", i+1))*gpsScale, float(sm.getCellValue("Long", i+1))*gpsScale, float(sm.getCellValue("Alt", i+1)));
    
    PVector geo = new PVector(float(sm.getCellValue("Long", i)), float(sm.getCellValue("Lat", i)));
    PVector projCoords = proj.transformCoords(geo);
    
    //println(geo.x+","+geo.y+" -> "+projCoords.x+","+projCoords.y);
    
    PVector nextGeo = new PVector(float(sm.getCellValue("Long", i+1)), float(sm.getCellValue("Lat", i+1)));
    PVector nextProjCoords = proj.transformCoords(nextGeo);
    
    
    //Interconnected
    //text(sm.getCellValue("Capital", i),projCoords.x/gpsScale , projCoords.y/gpsScale, float(sm.getCellValue("Alt", i)));
    //line(projCoords.x/gpsScale , projCoords.y/gpsScale,  float(sm.getCellValue("Alt", i)), nextProjCoords.x/gpsScale , nextProjCoords.y/gpsScale,  float(sm.getCellValue("Alt", i+1)));
    
    //Bars
    text(sm.getCellValue("Capital", i),projCoords.x/gpsScale , projCoords.y/gpsScale, float(sm.getCellValue("Alt", i)));
    line(projCoords.x/gpsScale , projCoords.y/gpsScale,  float(sm.getCellValue("Alt", i)), projCoords.x/gpsScale , projCoords.y/gpsScale,  0);
    
  };


  //endShape();
  //box(40);
}

void keyPressed() {
  if (keyCode == LEFT) {
    rotate_val = rotate_val - 0.01;
  } 
  if (keyCode == RIGHT) {
    rotate_val = rotate_val + 0.01;
  }
  if (keyCode == UP) {
    zoom = zoom + 10;
  }
  if (keyCode == DOWN) {
    zoom = zoom - 10;
  }
}

